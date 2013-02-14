From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 14 Feb 2013 07:03:51 -0800
Subject: [PATCH v9 02/20] mfd: omap-usb-host: Consolidate OMAP USB-HS
 platform data
In-Reply-To: <511CB9E9.5050804@ti.com>
References: <1358937492-8129-1-git-send-email-rogerq@ti.com>
 <1358937492-8129-3-git-send-email-rogerq@ti.com>
 <511CB9E9.5050804@ti.com>
Message-ID: <20130214150351.GD2033@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 12:18:17PM +0200, Roger Quadros wrote:
> Hi Greg,
> 
> On 01/23/2013 12:37 PM, Roger Quadros wrote:
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
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> > For the ehci-omap.c part:
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Could you please ACK the drivers/usb/host/ehci-omap.c part
> so that this can go through the MFD tree. Thanks.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
