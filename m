From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 14 Apr 2013 14:20:35 +0200
Subject: [PATCH 08/30] i2c: s3c2410: make header file local
In-Reply-To: <1365638712-1028578-9-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-9-git-send-email-arnd@arndb.de>
Message-ID: <20130414122035.GB9013@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:04:50AM +0200, Arnd Bergmann wrote:

> No other file in the kernel besides i2c-s3c2410.c uses the current
> plat/regs-iic.h, so we can simply move the header file to live in the
> same directory as the driver, as a preparation to multiplatform builds.

What about putting the regs in the driver itself?
