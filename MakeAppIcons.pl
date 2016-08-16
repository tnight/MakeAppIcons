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

use File::Basename;

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

sub makeImageMagickCommand($;$;$) {
  my ($inputImageName, $outputImageName, $pixelSize) = @_;

  myLog('error', "Entering makeImageMagickCommand.\n");

  my $imCommand = qq(convert -flatten -resize ${pixelSize}x${pixelSize} +repage '$inputImageName' '$outputImageName');

  myLog('error', "Exiting makeImageMagickCommand.\n");

  return $imCommand;
}

sub convertImages($;$) {
  my ($inputImageName, $outputImagePrefix) = @_;

  myLog('error', "Entering convertImages.\n");
  myLog('error', "\$inputImageName = [$inputImageName]\n");
  myLog('error', "\$outputImagePrefix = [$outputImagePrefix]\n");

  # Get the file extension to use for output files.
  my ($name, $path, $fileExtension) = fileparse($inputImageName, qr/\.[^.]*/);
  myLog('error', "\$name = [$name]\n");
  myLog('error', "\$path = [$path]\n");
  myLog('error', "\$fileExtension = [$fileExtension]\n");

  # Define the pixel sizes of the images we will output.
  my @pixelSizes = qw(29 40 58 76 80 87 120 152 167 180);

  foreach my $pixelSize (@pixelSizes) {
    my $outputImageName = sprintf("%s %03dpx%s", $outputImagePrefix,
      $pixelSize, $fileExtension);
    myLog('error', "\$outputImageName = [$outputImageName]\n");

    # Generate the ImageMagick command to resize the image.
    my $imCommand = makeImageMagickCommand($inputImageName, $outputImageName, $pixelSize);
    myLog('error', "About to run ImageMagick command: [$imCommand]\n");

    # Run the command to resize the image.
    my $imReturnCode = system($imCommand);

    myLog('error', "\$imReturnCode was: [$imReturnCode]\n");
    if ($imReturnCode != 0) {
      die("ImageMagick command [$imCommand] failed: error $?");
    }
  }

  myLog('error', "Exiting convertImages.\n");
}

sub main() {
  if (scalar(@ARGV) != 2) {
    usage();
    exit(1);
  }

  convertImages($ARGV[0], $ARGV[1]);
}

main();

# End of file
