#!/usr/bin/perl -w
#
# (c)Copyright, Terry Nightingale 2016
#
# usage: MakeAppIcons.pl <input-image-name.xxx> <output-image-prefix>
#
# Input image must be at least 180x180 pixels in size and must be
# square (same pixel height and width). Output files will have names like:
#
# <output-image-prefix> NNNpx.xxx
#
# where NNN is the pixel size, and ".xxx" is the file name extension.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, version 2 only.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# Visit this URL for more information:
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
#
############################################################################

use strict;

sub usage() {
  print <<EOM;

usage: MakeAppIcons.pl <input-image-name.xxx> <output-image-prefix>

Input image must be at least 180x180 pixels in size and must be
square (same pixel height and width). Output files will have names like:

<output-image-prefix> NNNpx.xxx

where NNN is the pixel size, and ".xxx" is the file name extension.

EOM

}

sub myLog(+@) {
  my $level = shift;
  if ($level eq 'error') {
    print STDERR @_;
  }
  elsif ($level eq 'output') {
    print STDOUT @_;
  }
  else {
    print STDERR "!!! Invalid log level [$level] specified!", @_;
  }
}

sub convertImages($;$) {
  my ($inputImageName, $outputImagePrefix) = @_;

  myLog('error', "Entering convertImages.\n");

  ### TNIGHTIN: TODO: the magic(k) happens here...

  myLog('error', "Exiting convertImages.\n");
}

sub main() {
  if (scalar(@ARGV) != 2) {
    usage();
    exit(1);
  }

  convertImages(@ARGV);
}

main();

# End of file
