From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 18 Jan 2013 03:54:51 +0000
Subject: [PATCH v4 0/3] mtd: nand: OMAP: ELM error correction support
 for BCH ecc
In-Reply-To: <1358424375.2731.234.camel@sauron.fi.intel.com>
References: <1357286211-5012-1-git-send-email-avinashphilip@ti.com>
 <518397C60809E147AF5323E0420B992E3EA5DFA9@DBDE01.ent.ti.com>
 <1358424375.2731.234.camel@sauron.fi.intel.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA5F353@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 17:36:15, Artem Bityutskiy wrote:
> On Wed, 2013-01-16 at 12:22 +0000, Philip, Avinash wrote:
> > > This series is based on linux 3.8-rc2 and tested with [1].
> > > Also this patch series depend on [1] for NAND flash device
> > > tree data and gpmc nand device tree binding documentation updates.
> > > 
> > > 1. [PATCH v7 0/5] OMAP GPMC DT bindings
> > > http://www.spinics.net/lists/linux-omap/msg83505.html
> > > 
> > > Tested on am335x-evm for BCH 4 and 8 bit error correction.
> > 
> > Can you apply this patch series on l2-mtd tree as it will help RBL compatibility
> > ecc layout for NAND flash in am335x-platforms and hardware based BCH error
> > correction.
> 
> OK, I've applied them. I dropped the part that updates the
> documentation. Please, handle it separately when Daniel's patches are
> in.
> 
> Pushed to l2-mtd.git, thanks!

Thanks for applying this patch series.
I will update gpmc-nand documentation part in a separate patch.

Thanks,
Avinash

> 
> -- 
> Best Regards,
> Artem Bityutskiy
> 
