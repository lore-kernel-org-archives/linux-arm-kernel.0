From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Oct 2013 21:03:12 -0700
Subject: [PATCH v3 03/10] ARM: OMAP2+: omap-usb-host: Get rid of
 platform_data from struct usbhs_phy_data
In-Reply-To: <524BF332.4080303@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
 <1380012836-29900-4-git-send-email-rogerq@ti.com>
 <524BF332.4080303@ti.com>
Message-ID: <20131003040311.GH8949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [131002 03:27]:
> Hi Tony,
> 
> On 09/24/2013 11:53 AM, Roger Quadros wrote:
> > The platform data bits can be inferred from the other members of
> > struct usbhs_phy_data. So get rid of the platform_data member.
> > 
> > Build the platform data for the PHY device in usbhs_init_phys() instead.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Could you please Ack this if OK?

This should be OK for you guys to queue. You should coordinate
the .dts changes with Benoit though. It might be best to have
this branch as an immutable branch against -rc3 that we can
all merge in as needed.

For this patch:

Acked-by: Tony Lindgren <tony@atomide.com>
