From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jul 2014 16:44:26 +0100
Subject: [PATCH] ARM: add revision info for PL310 errata 588369 and 727915
In-Reply-To: <20140707140708.GU30239@dragon>
References: <1404285816-3763-1-git-send-email-shawn.guo@freescale.com>
 <20140707140708.GU30239@dragon>
Message-ID: <20140707154426.GD21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 10:07:09PM +0800, Shawn Guo wrote:
> On Wed, Jul 02, 2014 at 03:23:36PM +0800, Shawn Guo wrote:
> > Add revision info for PL310_ERRATA_588369 and PL310_ERRATA_727915 to
> > help people understand if they need to enable the errata for their
> > hardware.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Any comments on this patch?  Otherwise, I'm going to throw it into
> the patch system.

I don't see anything wrong with this change.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
