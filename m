From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 11:16:24 -0800
Subject: [PATCH v2 2/4] ARM: OMAP: devices: create device for usb part
 of control module
In-Reply-To: <20130123112422.GF29258@arwen.pp.htv.fi>
References: <1358777308-2409-1-git-send-email-kishon@ti.com>
 <1358777308-2409-3-git-send-email-kishon@ti.com>
 <20130123112422.GF29258@arwen.pp.htv.fi>
Message-ID: <20130201191624.GR22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130123 03:27]:
> Hi,
> 
> On Mon, Jan 21, 2013 at 07:38:26PM +0530, Kishon Vijay Abraham I wrote:
> > A seperate driver has been added to handle the usb part of control
> > module. A device for the above driver is created here, using the register
> > address information to be used by the driver for powering on the PHY and
> > for writing to the mailbox.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Tony ? Without this we won't have the control module driver.

Looks OK to me, but please see my other reply regarding on
you setting up some immutable branches to avoid pointless
merge conflicts.

Regards,

Tony
