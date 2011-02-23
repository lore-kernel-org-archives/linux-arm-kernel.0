From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 23 Feb 2011 09:55:30 +0100
Subject: [PATCH] ARM: mx51_defconfig: change CONFIG_LEDS_CLASS 'm' to 'y'
In-Reply-To: <1298448415-21986-1-git-send-email-shawn.guo@freescale.com>
References: <1298448415-21986-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110223085530.GO22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Feb 23, 2011 at 04:06:55PM +0800, Shawn Guo wrote:
> This patch is to fix the warning below.
> 
> arch/arm/configs/mx51_defconfig:113:warning: symbol value 'm' invalid for LEDS_CLASS
I fixed that in my local tree, too, together with some more things.
Actually I thought I already sent it out, but my mailboxes seem to
not agree.  I wanted to update my pull request for Sascha today anyhow
and can put that one in, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
