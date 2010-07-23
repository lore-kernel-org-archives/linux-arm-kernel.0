From: augulis.darius@gmail.com (Darius Augulis)
Date: Fri, 23 Jul 2010 22:12:03 +0300
Subject: real6410 support
Message-ID: <4C49E983.1030001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

there is a nice s3c6410 board named real6410.
I would like to buy it and develop product on it.
Because it's quite expensive, before I buy it, I would like to know 
about kernel support for it. Is there any differences between smdk6410 
and real6410? Board manufacturer doesn't provide any schematics of this 
board. I found kernel and u-boot packages for real6410 on the net:

http://code.google.com/p/real6410/source/browse/trunk/soft/s3c-linux-2.6.28-Real6410.tar.bz2

http://code.google.com/p/real6410/source/browse/trunk/soft/s3c-u-boot-1.1.6-Real6410.tar.bz2

Quick look into kernel .config showed:

CONFIG_MACH_SMDK6410=y

Does it mean that I can compile main line kernel for mach-smdk6410 and I 
will have all real6410 devices working?

Thanks for info!

Darius.
