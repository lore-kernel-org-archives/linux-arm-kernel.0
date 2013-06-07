From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 7 Jun 2013 12:46:23 +0300
Subject: [PATCH 14/14] ARM: OMAP4: hwmod data: Clean up the data file
In-Reply-To: <51B1A150.9020307@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-15-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306061754560.5152@utopia.booyaka.com>
 <51B0D54A.1090107@ti.com> <51B175E4.1060909@ti.com>
 <alpine.DEB.2.02.1306070751210.32163@utopia.booyaka.com>
 <51B1A150.9020307@ti.com>
Message-ID: <1370598383.25965.73.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-06-07 at 14:31 +0530, Sricharan R wrote:
> On Friday 07 June 2013 01:22 PM, Paul Walmsley wrote:
> > cc Beno?t
> >
> > On Fri, 7 Jun 2013, Sricharan R wrote:
> >
> >> I used autogen to remove the data, but some of the data were not in sync
> >> with the mainline .(like abe, dss, aess, context register offsets etc..).
> >> So i have to sync them manually.
> > OK.  Are you going to fix the differences up soon?
> >
> > - Paul
> + Ambresh and Tero for autogen.

This is not going to happen soon, if ever. We might consider doing this
if a complete overhaul for the hwmod data is going to be done at some
point so that re-generating the new format is easier.

-Tero
