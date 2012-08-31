From: tony@atomide.com (Tony Lindgren)
Date: Fri, 31 Aug 2012 08:36:02 -0700
Subject: [PATCH 0/9] Clean up hardcoded IRQs for mach-omap2, enable
 SPARSE_IRQ, plaform_data/gpio-omap.h
In-Reply-To: <5040528E.80509@gmail.com>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <5040528E.80509@gmail.com>
Message-ID: <20120831153601.GJ1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [120830 22:59]:
> On 08/30/2012 07:52 PM, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's the first set of omap header clean-up patches needed for single
> > zImage support. This series is based v3.6-rc3 and the following patches
> > to avoid merge conflicts with the includes:
> > 
> > - Arnd's patch "ARM: omap: move platform_data definitions"
> > - Igor's series "ARM: OMAP: cleanup plat/board.h file"
> > - Afzal's series "Prepare for GPMC driver conversion (w.r.t MTD)"
> > 
> 
> Looks like I can drop my omap gpio changes with this. Do you have a git
> tree with this?

Yes no need for those changes for omap :) I have not pushed out any
branch yet, I'm waiting on the scripted platform data move Arnd announced
later on in the "[PATCH 4/4] [RFC] ARM: treewide: manually change more"
thread that are now in the arm-soc tree testing/platform-data branch.

Regards,

Tony
