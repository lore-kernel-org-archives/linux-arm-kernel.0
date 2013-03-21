From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Thu, 21 Mar 2013 11:51:24 +0100
Subject: [PATCH 1/2] i2c: s3c2410: move mach/regs-iic.h into i2c-s3c2410
 device driver
In-Reply-To: <20130321095758.GB19297@the-dreams.de>
References: <201302080057.00664.heiko@sntech.de>
 <20130321095758.GB19297@the-dreams.de>
Message-ID: <201303211151.24997.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Am Donnerstag, 21. M?rz 2013, 10:57:58 schrieb Wolfram Sang:
> On Fri, Feb 08, 2013 at 12:57:00AM +0100, Heiko St?bner wrote:
> > The register definitions are only used in the driver itself.
> > This also removes the last dependency on plat/ includes from the
> > i2c driver.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> What tree is this against? I can't apply it on top of v3.8 or 3.9-rc3.

I'm not sure anymore ... probably some linux-next. I'll redo them on top of 
your (i2c) for-next branch.


Heiko
