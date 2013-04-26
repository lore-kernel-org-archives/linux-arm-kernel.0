From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Apr 2013 08:51:38 -0700
Subject: [PATCH 1/3] ARM: OMAP2+: Legacy support for wl12xx when booted
 with devicetree
In-Reply-To: <0104F687-1726-476D-B2DF-7E72223B127A@dominion.thruhere.net>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
 <20130426035210.26065.39995.stgit@muffinssi.local>
 <0104F687-1726-476D-B2DF-7E72223B127A@dominion.thruhere.net>
Message-ID: <20130426155138.GB29360@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Koen Kooi <koen@dominion.thruhere.net> [130426 02:39]:
> 
> Op 26 apr. 2013, om 05:52 heeft Tony Lindgren <tony@atomide.com> het volgende geschreven:
> 
> > Without WLAN we cannot switch omap4 to use device tree
> > only booting. This patch can be reverted when the
> > binding for wl12xx is added.
> 
> How much boards am I allowed to add to this? I need to get the wl12xx wifi expansionboards for beagleboard, beagleboard xM and beaglebone working with DT :)

As long as it's trivial changes, go for it. It will be
gone after we have the binding for wl12xx.

But let's not add the bluetooth serial port hack.. And
let's not churn the board-*.c files, at this point pretty
much the next step is to start dropping the board-*.c
files.

Regards,

Tony
