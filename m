From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Nov 2013 08:56:39 -0800
Subject: [PATCH] ARM: dts: Add missing reg, interrupt and dma entries
 for omap3
In-Reply-To: <20131110234717.GA29968@earth.universe>
References: <20131017221522.GE15154@atomide.com>
 <20131110234717.GA29968@earth.universe>
Message-ID: <20131111165638.GP15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@ring0.de> [131110 15:48]:
> Hi Tony,
> 
> On Thu, Oct 17, 2013 at 03:15:22PM -0700, Tony Lindgren wrote:
> > Looks like omap3 is still relying on hwmod data for some basic
> > device tree information. Let's add the information to omap3.dtsi
> > so we can remove the related hwmod data once omap3 is DT only.
> 
> This patch fixes a regression in omap3 DT boot introduced by
> commit 2a0b965cfb6efc667228831fc3a30308b4f94a87. This commit
> assumes, that interrupts are specified via DT data if booted
> via DT.

Yes sorry about that, this should have been merged as a fix
earlier to avoid breaking things during the merge window.
Looks like I only tested 2a0b965cfb6efc667228831fc3a30308b4f94a87
separately on omap4 or something and forgot about the dependency.

Regards,

Tony
