From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Jan 2015 15:27:56 +0100
Subject: Regression with legacy IRQ numbers caused by 9a1091ef0017
In-Reply-To: <8761c8i2hq.fsf@approximate.cambridge.arm.com>
References: <20150114221407.GS2419@atomide.com>
 <8761c8i2hq.fsf@approximate.cambridge.arm.com>
Message-ID: <2776397.iNGHcrIBZz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 January 2015 13:42:57 Marc Zyngier wrote:
> Of course, this is in no way a proper fix, but I suppose the OMAP DT is
> still missing a few bits...

I must be missing something here, but all the interrupts are listed
correctly in the DT, so what is the omap_hwmod_irq_info actually
achieving on omap4 and omap5?

Would it work if we just remove the incorrect copy of the resource
and use the one that comes from DT?

	Arnd
