From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 30 Sep 2012 10:28:02 +0200
Subject: Booting vanilla kernel on the beaglebone
Message-ID: <20120930082802.GA15392@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I just received by very own beaglebone, and I would like to add PTP
hardware clock support for the CPTS unit, but I naturally want to do
this with the latest mainstream kernel and not the hacked up arago 3.2
kernel that ships with the board.

Does any vanilla kernel even boot on this board?
If so, which ones, and how?

I have tried a few variations of kernel/u-boot without any luck.
The u-boot that came with the board is

  U-Boot 2011.09-00000-gf63b270-dirty (Apr 24 2012 - 09:51:01)
  arm-angstrom-linux-gnueabi-gcc (GCC) 4.5.4 20120305 (prerelease)
  GNU ld (GNU Binutils) 2.20.1.20100303

and I also tried the latest version:

  U-Boot 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)
  arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2009q1-203) 4.3.3
  GNU ld (Sourcery G++ Lite 2009q1-203) 2.19.51.20090205

Thanks,
Richard
