From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Aug 2015 03:40:43 -0700
Subject: [PATCH 00/11] omap_hsmmc: voltage switching and tuning
In-Reply-To: <55C4C46E.9080200@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
 <20150805104355.GE16878@atomide.com> <55C22524.5050304@ti.com>
 <20150806064821.GO16878@atomide.com> <55C4C46E.9080200@ti.com>
Message-ID: <20150811104043.GL4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [150807 07:48]:
> Hi,
> 
> On Thursday 06 August 2015 12:18 PM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [150805 08:03]:
> >> Hi,
> >>
> >> On Wednesday 05 August 2015 04:13 PM, Tony Lindgren wrote:
> >>> * Kishon Vijay Abraham I <kishon@ti.com> [150730 00:49]:
> >>>> Patch series implements voltage switching and tuning for omap_hsmmc
> >>>> driver.
> >>>>
> >>>> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
> >>>> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.
> >>>
> >>> Your tests are missing omap3?
> >>
> >> I don't have one at my disposal :-( I'll try to find one and add omap3 tests.
> > 
> > Great :) Beagle xm is a good one to test the USB PHY stuff on
> > and also MMC. Having USB cable connected or EHCI loaded blocks the PM
> > though, so NFSroot is not very usable for testing on it.
> 
> I found a beagle xm. So I should be able to get back to this early next week.

OK great!

Thanks,

Tony
