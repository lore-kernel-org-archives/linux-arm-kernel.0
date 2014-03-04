From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Mar 2014 10:47:51 -0800
Subject: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
In-Reply-To: <53144CBC.2050607@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <20140228225627.GU13624@atomide.com> <53144CBC.2050607@ti.com>
Message-ID: <20140304184750.GB8771@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [140303 01:38]:
> Hi Tony,
> 
> On 03/01/2014 12:56 AM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [140227 06:21]:
> >> Hi,
> >>
> >> This patchset brings up USB Host ports and Ethernet port on
> >> the OMAP5 uEVM board.
> >>
> >> It also does some cleanup with respect to DT clock binding
> >> for the mfd/omap-usb-host driver.
> >>
> >> Please queue these for -next.
> >>
> >> Lee,
> >>
> >> I've folded some platform data dependent patches with mfd patches
> >> so that they don't break functionality when applied individually.
> >> You can safely pull in all MFD patches (1 to 6).
> >>
> >> Tony & Benoit,
> >>
> >> Can you please accept patches 7, 8 and 9?
> > 
> > Are 7, 8 and 9 safe to queue separately from the MFD changes
> > or do they need to wait for the MFD changes to get merged
> > first?
> > 
> 
> They are safe to queue separately.

OK thanks applying 7, 8 and 9 into omap-for-v3.15/dt.

Regards,

Tony
