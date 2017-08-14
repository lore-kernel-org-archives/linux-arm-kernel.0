From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Aug 2017 10:09:26 +0100
Subject: [PATCH v2 0/9] EDAC drivers for Armada XP L2 and DDR
In-Reply-To: <1502701288.2922.6.camel@pengutronix.de>
References: <20170802123922.11498-1-jlu@pengutronix.de>
 <20170802140505.GA2290@nazgul.tnic>
 <1502701288.2922.6.camel@pengutronix.de>
Message-ID: <20170814090926.GF20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 11:01:28AM +0200, Jan L?bbe wrote:
> Hi Gregory and Borislav,
> 
> On Wed, 2017-08-02 at 16:05 +0200, Borislav Petkov wrote:
> > On Wed, Aug 02, 2017 at 02:39:13PM +0200, Jan Luebbe wrote:
> > > Chris Packham (2):
> > > ? ARM: l2x0: support parity-enable/disable on aurora
> > > ? ARM: l2x0: add marvell,ecc-enable property for aurora
> > > 
> > > Jan Luebbe (7):
> > > ? ARM: l2c: move cache-aurora-l2.h to asm/hardware
> > > ? ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
> > > ? ARM: aurora-l2: add defines for parity and ECC registers
> > 
> > I'd need an ACK from an ARM maintainer for those if the whole series
> > is going to go through the EDAC tree.
> 
> Gregory, you've given Reviewed-by tags for some of these in version 1.?
> 
> Would you be fine with acking them and merging the series through the
> EDAC tree?

Boris and myself agreed that I'd merge the entire series once the
EDAC bits have been reviewed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
