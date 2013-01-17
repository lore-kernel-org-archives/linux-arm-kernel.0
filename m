From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Jan 2013 08:59:44 -0800
Subject: [PATCH v7 01/22] mfd: omap-usb-host: Consolidate OMAP USB-HS
 platform data
In-Reply-To: <Pine.LNX.4.44L0.1301171016090.1339-100000@iolanthe.rowland.org>
References: <1358422231-24736-2-git-send-email-rogerq@ti.com>
 <Pine.LNX.4.44L0.1301171016090.1339-100000@iolanthe.rowland.org>
Message-ID: <20130117165943.GI14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alan Stern <stern@rowland.harvard.edu> [130117 07:19]:
> On Thu, 17 Jan 2013, Roger Quadros wrote:
> 
> > Let's have a single platform data structure for the OMAP's High-Speed
> > USB host subsystem instead of having 3 separate ones i.e. one for
> > board data, one for USB Host (UHH) module and one for USB-TLL module.
> > 
> > This makes the code much simpler and avoids creating multiple copies of
> > platform data.
> > 
> > CC: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> For the ehci-omap.c part:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

If Samuel acks this patch, I can apply just this patch alone on v3.8-rc3
into an immutable branch omap-for-v3.9/board-usb so we all merge it in
as needed.

Regards,

Tony
