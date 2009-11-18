From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 18 Nov 2009 11:29:16 +0100
Subject: my IXP4xx patch queue
In-Reply-To: <m3bpj06f05.fsf@intrepid.localdomain>
References: <m3bpj06f05.fsf@intrepid.localdomain>
Message-ID: <20091118102916.GC30544@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 17, 2009 at 10:03:06PM +0100, Krzysztof Halasa wrote:
> Hi,
> 
> I've updated my IXP4xx git tree (it's still being mirrored from hera at
> the moment). The usual disclaimer applies: it may be rebased at any
> time.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux-2.6.git ixp4xx
> http://git.kernel.org/?p=linux/kernel/git/chris/linux-2.6.git
> 
> It includes (discussed earlier):
> 
> 28b393 IXP4xx: change the timer base frequency to 66.666000 MHz.
> 3b739c IXP4xx: Fix normally-disabled debugging text in drivers/net/arm/ixp4xx_eth.c.
> b7aa5a ARM: fix insl() and outsl() endianness on IXP4xx architecture.
> 1f6d89 IXP4xx: Ensure index is positive in irq_to_gpio() and npe_request().
> 7ea97d IXP4xx: Rename indirect MMIO primitives from __ixp4xx_* to __indirect_*.
> 78091c ARM: Introduce HAVE_IOREAD_AND_IOWRITE macro.
> 766853 IXP4xx: Drop "__ixp4xx_" prefix from in/out/ioread/iowrite functions for clarity.
> c7c4c8 IXP4xx: Fix compilation failure with CONFIG_IXP4XX_INDIRECT_PCI.
> c11693 IXP4xx: Extend PCI MMIO indirect address space to 1 GB.
> 
> and my latest stuff with which I'm trying to simplify the IXP4xx code:
> 
> 072725 IXP4xx: move IXDP425 platform macros to the platform code.
> 13c284 IXP4xx: move AVILA platform macros to the platform code.
> cb1f52 IXP4xx: move Coyote platform macros to the platform code.
> cab003 IXP4xx: move NSLU2 platform macros to the platform code.
> 2abc9f IXP4xx: move NAS100D platform macros to the platform code.
> b38cf7 IXP4xx: move DSM G600 platform macros to the platform code.
> cd2939 IXP4xx: move FSG platform macros to the platform code.
> b764f5 IXP4xx: Remove unused Motorola PrPMC1100 platform macros.
> d09273 IXP4xx: move Gemtek GTWX5715 platform macros to the platform
> code.
> 
> I'm not sure I like this one very much:
> 
> e13d20 IXP4xx: Introduce IXP4XX_GPIO_IRQ(n) macro and convert IXP4xx platform files.
> 
> 
> Comments welcome as always.
> 
> I'll git-send-email the latest stuff now. No In-Reply-To:/References
> since I think the mailserver will hold/drop any mail lacking "Re: "
> with these headers.
AFAIK this is not true if your headers match
/^X-Mailer: git-send-email/ .

My last series took 13 minutes on infradead.org machines and I didn't
get any bounces about being moderated and the mails don't have headers
suggesting that they were manually accepted.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
