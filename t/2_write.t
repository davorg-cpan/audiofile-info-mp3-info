use strict;
use warnings;

use Test::More;

use AudioFile::Info;

use File::Copy;
use FindBin qw($Bin);

SKIP: {
  skip "AudioFile::Info::MP3::Info doesn't support writing yet", 14;

  copy "$Bin/test.mp3", "$Bin/test2.mp3";

  my $song = AudioFile::Info->new('t/test2.mp3',
                                  { mp3 => 'AudioFile::Info::MP3::Info' });
  is(ref $song, 'AudioFile::Info::MP3::Info');
  is($song->title, 'test');
  is($song->artist, 'davorg');
  is($song->album, 'none');
  is($song->track, '0');
  is($song->year, '2003');
  is($song->genre, 'nonsense');

  $song->title('xxx');
  $song->artist('xxx');
  $song->album('xxx');
  $song->track('1');
  $song->year('2000');
  $song->genre('xxx');

  undef $song;

  $song = AudioFile::Info->new('t/test2.mp3',
                               { mp3 => 'AudioFile::Info::MP3::Info' });
  is(ref $song, 'AudioFile::Info::MP3::Info');
  is($song->title, 'xxx');
  is($song->artist, 'xxx');
  is($song->album, 'xxx');
  is($song->track, '1');
  is($song->year, '2000');
  is($song->genre, 'xxx');

  unlink("$Bin/test2.mp3");
}

done_testing();
