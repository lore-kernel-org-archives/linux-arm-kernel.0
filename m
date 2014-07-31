From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 31 Jul 2014 09:10:11 +0800
Subject: [PATCH v2 2/2] ARM: smp_scu: enable SCU standby support
In-Reply-To: <20140729124410.GI24750@dragon>
References: <1406275790-18617-1-git-send-email-shawn.guo@freescale.com>
 <1406275790-18617-3-git-send-email-shawn.guo@freescale.com>
 <20140729124410.GI24750@dragon>
Message-ID: <20140731011010.GA2171@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 08:44:11PM +0800, Shawn Guo wrote:
> On Fri, Jul 25, 2014 at 04:09:50PM +0800, Shawn Guo wrote:
> > With SCU standby enabled, SCU CLK will be turned off when all processors
> > are in WFI mode.  And the clock will be turned on when any processor
> > leaves WFI mode.
> > 
> > This behavior should be preferable in terms of power efficiency of
> > system idle.  So let's set the SCU standby bit to enable the support in
> > function scu_enable().
> > 
> > Cortex-A9 earlier than r2p0 has no standby bit in SCU, so we need to
> > skip setting the bit for those.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> If there is no objection on the patch, I will put it into patch tracker
> soon.

Submitted these two patches as #8121 and #8122.

Shawn
