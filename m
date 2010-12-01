From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Dec 2010 11:08:27 +0000
Subject: [PATCH 1/3] ARM: SAMSUNG: Convert s3c_irqext_wake() to new
	irq_ interrupt methods
In-Reply-To: <20101201101902.GA22683@mail.wantstofly.org>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20101201101902.GA22683@mail.wantstofly.org>
Message-ID: <20101201110827.GB24176@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 11:19:02AM +0100, Lennert Buytenhek wrote:

> It would seem that this patch breaks s3c:

> ./mach-s3c64xx/irq-eint.c:	.irq_set_wake	= s3c_irqext_wake,
> ./plat-s3c24xx/irq.c:	.irq_set_wake	= s3c_irqext_wake

Could you please elaborate on what you mean by "s3c" and why you think
it has been broken?
