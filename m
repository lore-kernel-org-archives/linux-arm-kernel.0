From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 17:53:29 -0700
Subject: [PATCH v2 00/16] Switch GIC users (and omap2plus) to
	CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <20110927235309.GP6324@atomide.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<20110927235309.GP6324@atomide.com>
Message-ID: <20110928005329.GQ6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110927 16:19]:
> 
> * Marc Zyngier <marc.zyngier@arm.com> [110926 07:02]:
> > 
> > This series has been tested on VE (A9, A5, A15), PB11MP, Panda, IGEPv2
> > and Harmony. Patches against next-20110926 plus my PPI series.
> 
> I gave this series a quick try, it works except with all the patches
> applied omap2plus_defconfig will failt to boot on omap4. It seems that
> the issue is somewhere in the GIC related patches, the last one just
> enables the MULTI_IRQ..
> 
> Care to give it a try on your Panda and see if omap2plus_defconfig
> works for you with this series?
> 
> Looks like disabling CONFIG_SMP made it omap4 boot again.

Nevermind, looks like I was missing the PPI series.. No wonder
I had to do some rebasing to get the patches to apply..

Booting just fine now, will ack some patches separately. Gave
the PPI + MULTI_IRQ series a quick boot test on n800, 2430sdp,
n900, zoom3 and blaze. So that pretty much covers omap2, 3 & 4.

Regards,

Tony
