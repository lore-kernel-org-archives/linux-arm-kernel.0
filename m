From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 2 Apr 2013 22:36:32 +0200
Subject: [PATCH 07/23] i2c: s3c2410: make header file local
In-Reply-To: <1362505353-8873-8-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <1362505353-8873-8-git-send-email-arnd@arndb.de>
Message-ID: <201304022236.32629.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 5. M?rz 2013, 18:42:17 schrieb Arnd Bergmann:
> No other file in the kernel besides i2c-s3c2410.c uses
> the current plat/regs-iic.h, so we can simply move the
> header file to live in the same directory as the driver,
> as a preparation to multiplatform builds.

A patch doing the same is already sitting in the i2c for-next branch [0].


Heiko



[0] https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/commit/?h=i2c/for-next&id=e636602ac2613da8c1777cb42443223994be4107
