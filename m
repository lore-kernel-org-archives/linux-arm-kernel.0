From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Sat, 27 Aug 2016 14:05:22 +0200
Subject: [PATCH] pcmcia: ds: fix suspend/resume
In-Reply-To: <E1bbFKU-0001OO-RA@rmk-PC.armlinux.org.uk>
References: <E1bbFKU-0001OO-RA@rmk-PC.armlinux.org.uk>
Message-ID: <20160827120522.GA3933@light.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sun, Aug 21, 2016 at 12:05:30AM +0100, Russell King wrote:
> PCMCIA suspend/resume no longer works since the commit mentioned below,
> as the callbacks are no longer made.  Convert the driver to the new
> dev_pm_ops, which restores the suspend/resume functionality.  Tested on
> the arm arch Assabet platform with a pcnet_cs CF card.
> 
> Fixes: aa8e54b559479 ("PM / sleep: Go direct_complete if driver has no callbacks")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Looks goot to me. Can you push it upstream, please?

Best
	Dominik
