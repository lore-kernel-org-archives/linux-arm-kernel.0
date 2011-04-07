From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 7 Apr 2011 18:39:17 +0200
Subject: [patch 0/2] s3c24xx: add GPIO DT support
Message-ID: <20110407163917.GA17498@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is my first attempt to add some DeviceTree support to the s3c24xx
ARM SOC platform.

On my QQ2440 this allows the usage of dts to define leds behaviour and
remove immediately some code from the mach-qq2440.c (yet to be merged).

Thanks,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
