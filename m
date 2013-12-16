From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Dec 2013 14:38:27 -0800
Subject: [PATCH v3 0/2] usb: fix controller-PHY binding for OMAP3 platform
In-Reply-To: <20131216212918.GH12896@saruman.home>
References: <1387209225-11520-1-git-send-email-kishon@ti.com>
 <20131216212918.GH12896@saruman.home>
Message-ID: <20131216223826.GG26293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [131216 13:31]:
> Hi,
> 
> On Mon, Dec 16, 2013 at 09:23:43PM +0530, Kishon Vijay Abraham I wrote:
> > After the platform devices are created using PLATFORM_DEVID_AUTO, the
> > device names given in usb_bind_phy (in board file) does not match with
> > the actual device name causing the USB PHY library not to return the
> > PHY reference when the MUSB controller request for the PHY in the non-dt boot
> > case.
> > So removed creating platform devices using PLATFORM_DEVID_AUTO in omap2430.c.
> > 
> > Did enumeration testing in omap3 beagle.
> > 
> > Changes from v2:
> > * Fixed the commit log
> > 
> > Changes from v1:
> > * refreshed to the latested mainline kernel
> > * added musb_put_id from omap2430 remove.
> 
> Tony, how do you want to handle this ? You want me to provide you a
> branch which we both merge ?

Yes that would be great thanks. For the mach-omap2 touching parts:

Acked-by: Tony Lindgren <tony@atomide.com>
