From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 10:11:12 +0200
Subject: [PATCH v3 05/10] i2c: s3c2410: make header file local
In-Reply-To: <201304112343.34534.heiko@sntech.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
 <1365716245-99231-6-git-send-email-arnd@arndb.de>
 <201304112343.34534.heiko@sntech.de>
Message-ID: <201304121011.13028.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 April 2013, Heiko St?bner wrote:
> Am Donnerstag, 11. April 2013, 23:37:20 schrieb Arnd Bergmann:
> > No other file in the kernel besides i2c-s3c2410.c uses the current
> > plat/regs-iic.h, so we can simply move the header file to live in the
> > same directory as the driver, as a preparation to multiplatform builds.
> 
> There is already a patch doing similar changes [0] in the i2c tree for 3.10
> 

Excellent, that patch is actually nicer than my version, thanks for taking
care of this! I'll drop my patch from the series then.

	Arnd
