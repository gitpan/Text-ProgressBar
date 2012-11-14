package Text::ProgressBar::BouncingBar;
use Moose; 
our $VERSION = '0.1';
use Text::ProgressBar;

extends 'Text::ProgressBar::Bar';

sub update{
    my $self  = shift;
    my $pbar  = shift;
    my $width = shift;
    my ($left, $marker, $right) = ($self->left, $self->marker, $self->right);
    $width -= length($left) + length($right); 
    return sprintf("%s%s%s", $left, $marker x $width, $right) if ($pbar->finished);
    my $position = int($pbar->currval % ($width * 2 -1));
    $position = $width * 2 - $position if ($position > $width);
    my $lpad = $self->fill x ($position - 1);
    my $rpad = $self->fill x ($width - length($marker) - length($lpad));
    # Swap if we want to bounce the other way
    ($rpad, $lpad) = ($lpad,$rpad) if (!$self->fill_left);
    return sprintf("%s%s%s%s%s", $left, $lpad, $marker, $rpad, $right);
}

no Moose;
1;
__END__

=pod
 
=head1 NAME
 
Text::ProgressBar::BouncingBar
 
=head1 VERSION
 
version 0.1
 
=head1 SYNOPSIS

    use Text::ProgressBar::BouncingBar;

    my $prevbar = Text::ProgressBar->new(maxval => 300, widgets  => [Text::ProgressBar::Percentage->new(), Text::ProgressBar::ReverseBar->new()]);
    $prevbar->start();
    for my $i (1..300) {
        sleep 0.01;
        $prevbar->update($i+1);
    }
    $prevbar->finish;

=head1 DESCRIPTION
 
Updates the progress bar and its subcomponents. It inherites all
attribute of 'Bar'.

=head1 METHODS

=head2 update

handler for redrawing current regions within the area. (Inherited from Widget.)

=head1 AUTHOR

Farhad Fouladi, C<< <farhad at cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Farhad Fouladi.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
