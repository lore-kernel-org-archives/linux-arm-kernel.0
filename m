From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Mon, 14 Aug 2017 11:01:28 +0200
Subject: [PATCH v2 0/9] EDAC drivers for Armada XP L2 and DDR
In-Reply-To: <20170802140505.GA2290@nazgul.tnic>
References: <20170802123922.11498-1-jlu@pengutronix.de>
 <20170802140505.GA2290@nazgul.tnic>
Message-ID: <1502701288.2922.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory and Borislav,

On Wed, 2017-08-02 at 16:05 +0200, Borislav Petkov wrote:
> On Wed, Aug 02, 2017 at 02:39:13PM +0200, Jan Luebbe wrote:
> > Chris Packham (2):
> > ? ARM: l2x0: support parity-enable/disable on aurora
> > ? ARM: l2x0: add marvell,ecc-enable property for aurora
> > 
> > Jan Luebbe (7):
> > ? ARM: l2c: move cache-aurora-l2.h to asm/hardware
> > ? ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
> > ? ARM: aurora-l2: add defines for parity and ECC registers
> 
> I'd need an ACK from an ARM maintainer for those if the whole series
> is going to go through the EDAC tree.

Gregory, you've given Reviewed-by tags for some of these in version 1.?

Would you be fine with acking them and merging the series through the
EDAC tree?

> > ? EDAC: Add missing debugfs_create_x32 wrapper
> > ? EDAC: Add devres helpers for
> > ????edac_mc_alloc/edac_mc_add_mc(_with_groups)
> > ? EDAC: Add devres helpers for
> > ????edac_device_alloc_ctl_info/edac_device_add_device
> > ? EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC
> 
> Alternatively, I can review those and they can go through an ARM
> tree.
> 
> I'm fine with whatever ARM maintainers prefer.

Thanks, if you have any review comments, please let me know.

Regards,
Jan
