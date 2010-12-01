From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Dec 2010 11:33:17 +0000
Subject: [PATCH 1/3] ARM: SAMSUNG: Convert s3c_irqext_wake() to new
	irq_ interrupt methods
In-Reply-To: <002f01cb914a$de3e3fa0$9ababee0$%kim@samsung.com>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<002f01cb914a$de3e3fa0$9ababee0$%kim@samsung.com>
Message-ID: <20101201113317.GH24176@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 08:28:22PM +0900, Kukjin Kim wrote:

> And...as you know, need to convert s3c_irq_wake() to new irq_ interrupt
> method also.
> Ok...I will do it or will check Lennert Buytenhek's patch for it :-)

Yup, there's a lot of other IRQ stuff in the various Samsung platforms
that can be converted - as you can see I was working through the various
interrupts one at a time.  Lennart's patch covers everything but only
does the mechanical side of things.
