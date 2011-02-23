From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 23 Feb 2011 17:03:01 +0800
Subject: [PATCH] ARM: mx51_defconfig: change CONFIG_LEDS_CLASS 'm' to 'y'
In-Reply-To: <20110223085530.GO22310@pengutronix.de>
References: <1298448415-21986-1-git-send-email-shawn.guo@freescale.com>
	<20110223085530.GO22310@pengutronix.de>
Message-ID: <20110223090300.GA21911@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Feb 23, 2011 at 09:55:30AM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Wed, Feb 23, 2011 at 04:06:55PM +0800, Shawn Guo wrote:
> > This patch is to fix the warning below.
> > 
> > arch/arm/configs/mx51_defconfig:113:warning: symbol value 'm' invalid for LEDS_CLASS
> I fixed that in my local tree, too, together with some more things.
> Actually I thought I already sent it out, but my mailboxes seem to
> not agree.  I wanted to update my pull request for Sascha today anyhow
> and can put that one in, too.
> 
Feel free to drop mine, as long as we get it fixed.

-- 
Regards,
Shawn
