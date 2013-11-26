From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Nov 2013 14:27:03 -0800
Subject: [PATCH] ARM: dts: omap3-beagle: Fix USB host on beagle boards
 (for 3.13)
In-Reply-To: <52946243.70903@ti.com>
References: <1385387745-7162-1-git-send-email-rogerq@ti.com>
 <CAGo_u6ryFJvBwd=S9A-nJw+eoGguPj0jMOtgMiZ7mXXAbh4i+w@mail.gmail.com>
 <52946243.70903@ti.com>
Message-ID: <20131126222703.GQ26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [131126 00:57]:
> On 11/25/2013 05:50 PM, Nishanth Menon wrote:
> > On Mon, Nov 25, 2013 at 7:55 AM, Roger Quadros <rogerq@ti.com> wrote:
> >> Beagle (rev. C4) and Beagle-XM (all revs) need VAUX2 1.8V supply
> >> for the USB PHY.
> >>
> >> As the generic PHY driver can't handle more than one supply
> >> at the moment, we configure this supply to be always on.
> >> This will cause a very small power impact if the USB host subsystem
> >> is not in use, about 76.86 micro-W + LDO power.
> > 
> >>
> >> Older Beagle boards (prior to C4) don't have VAUX2 connected anywhere,
> >> so there won't be any functional impact on those boards other than
> >> some additional LDO power consumption.
> >>
> >> Reported-by: Nishanth Menon <nm@ti.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> > 
> > Tested-by: Nishanth Menon <nm@ti.com>
> 
> Thanks Nishant.

Thanks, applying this into omap-for-v3.13/fixes-take4.

Tony
