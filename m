From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 20 Mar 2012 03:17:16 -0600 (MDT)
Subject: [PATCH v3 1/2] arm: omap3: pm34xx.c: Fix omap3_pm_init() error
 out paths
In-Reply-To: <1332150525.2116.334.camel@sokoban>
References: <1332033768-21986-1-git-send-email-mgreer@animalcreek.com>
 <1332033768-21986-2-git-send-email-mgreer@animalcreek.com>
 <1332150525.2116.334.camel@sokoban>
Message-ID: <alpine.DEB.2.00.1203200316300.22974@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Kevin

On Mon, 19 Mar 2012, Tero Kristo wrote:

> On Sat, 2012-03-17 at 18:22 -0700, Mark A. Greer wrote:
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > It appears that the error paths were overlooked when the
> > omap3_pm_init() routine had the prcm chain handler code
> > added.  Fix this by adding a goto target and reordering
> > the error handling code.  Also fix how the irq argument
> > for free_irq() is determined.
> 
> You are right, it looks like the error handling part was accidentally
> dropped from version 7 of the prcm patch set.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>
> 
> Paul, you going to grab this?

Kevin is the pm34xx.c maintainer, so unless he wants me to queue it, it's 
probably best for him to take it.


- Paul
