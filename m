From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Jul 2012 03:13:15 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: hwmod: Hook-up am33xx support in omap_hwmod
 framework
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA624A5@DBDE01.ent.ti.com>
References: <1340898256-22884-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA624A5@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1207040311400.6760@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jul 2012, Hiremath, Vaibhav wrote:

> On Thu, Jun 28, 2012 at 21:14:16, Hiremath, Vaibhav wrote:
> > AM33XX PRCM architecture is different that any OMAP family
> > of devices, so it is required to have separate implementation
> > to handle AM33XX module enable/disable, reset assert/deassert
> > functionality.
> > This patch adds wrapper api's in omap_hwmod framework to
> > access prm/cm for AM33XX family of devices.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> 
> Ping !!!

Doesn't this have a cross-dependency on Kevin's series that is part of 
this tag:

http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=tag;h=0c66cfc31db4d4fc97c50ecf96fc5e3807a039ee

?

If so then it probably makes sense for this to wait until 3.7, since 
Tony's AM33xx devel branch is based on v3.5-rc1.


- Paul
