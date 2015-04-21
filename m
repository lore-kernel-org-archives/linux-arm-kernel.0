From: dashie@sigpipe.me (Dashie)
Date: Tue, 21 Apr 2015 15:10:04 +0200
Subject: Problem booting with 3.16 and custom build
Message-ID: <DF3D8491-92E2-4471-BC5B-BEC23F474897@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Still me working with my kirkwood board, i can get a 3.12 kernel from Debian working, but not with 3.16.

With 3.16 the USB (which i have an usb-key with the rootfs) doesn?t seems to be detected at all (no mentions of /usb/ in dmesg), no problem with 3.12.
Also don?t see any related USB changes between config-3.12 and 3.16 diffs which can cause that.

If i build a custom kernel (with config-3.12-1-kirkwood or even the one from 3.16), ARCH=arm and toolchain gcc-linaro-4.9-2014.11-x86_64_arm-linux-gnueabihf the boot from U-Boot
fails with:

=========
Starting kernel ...
 
undefined instruction
pc : [<0000ca30>]	   lr : [<0000bc4c>]
sp : 00228de0  ip : 00217b3c	 fp : 00217b10
r10: 00230f60  r9 : 006181d8	 r8 : 7d270000
r7 : 00008000  r6 : 0021fb40	 r5 : 0021fb40  r4 : 00000000
r3 : edfe0dd0  r2 : d00dfeed	 r1 : 0021fb40  r0 : 0021fb40
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32
Resetting CPU ?
=========

Any ideas for theses problems ?
At least getting the recent 3.16 booting properly will permit me to build and load modules easily.

Thanks.


PS. i do not remember if i?m subscribed to debian-arm@, please CC me when replying.
