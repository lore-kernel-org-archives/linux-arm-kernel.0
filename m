From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Mar 2010 10:41:28 -0800
Subject: [PATCH 2/3] usb: Fix USB_SUSPEND dependency for OTG
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321EC93DC@dbde02.ent.ti.com>
References: <20100311180329.20537.95308.stgit@baageli.muru.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0321EC93DC@dbde02.ent.ti.com>
Message-ID: <20100311184128.GK2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Gadiyar, Anand <gadiyar@ti.com> [100311 10:24]:
> Tony Lindgren wrote:
> > 
> > To use this, PM_RUNTIME must be set as discussed at:
> > 
> > http://thread.gmane.org/gmane.linux.usb.general/27432/focus=4460
> > 
> > Otherwise we'll get errors like:
> > 
> > drivers/usb/core/hcd.c:1892: error: 'pm_wq' undeclared (first use in this function)
> > drivers/usb/core/hcd.c:1892: error: (Each undeclared identifier is reported only once
> > drivers/usb/core/hcd.c:1892: error: for each function it appears in.)
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Hi Tony,
> 
> I already posted this patch last month. Still waiting for it
> to get queued.
> 
> <http://marc.info/?l=linux-usb&m=126675883221098&w=2>

OK thanks, I just found the thread but no patches. So my version
can then be dropped.

Tony
