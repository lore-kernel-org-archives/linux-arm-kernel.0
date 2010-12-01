From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Dec 2010 11:47:56 +0000
Subject: [PATCH 1/3] ARM: SAMSUNG: Convert s3c_irqext_wake() to new
	irq_ interrupt methods
In-Reply-To: <20101201114531.GK15575@mail.wantstofly.org>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20101201101902.GA22683@mail.wantstofly.org>
	<20101201110827.GB24176@rakim.wolfsonmicro.main>
	<20101201114531.GK15575@mail.wantstofly.org>
Message-ID: <20101201114755.GC5688@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 12:45:31PM +0100, Lennert Buytenhek wrote:

> My mistake, sorry -- I thought you had missed the two uses of
> s3c_irqext_wake in ./mach-s3c64xx/irq-eint.c and ./plat-s3c24xx/irq.c,
> but your patch does actually fix those up as well.

No problem, no wonder I couldn't figure out what you were talking about!
