From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 8 Mar 2013 16:05:56 +0800
Subject: [PATCH v11 4/9] usb: chipidea: udc: add pullup/pulldown dp at
 hw_device_state
In-Reply-To: <20130308071832.GE21589@arwen.pp.htv.fi>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-5-git-send-email-peter.chen@freescale.com>
 <20130306112633.GS28587@arwen.pp.htv.fi>
 <20130307023612.GC20470@nchen-desktop>
 <20130307095054.GK9171@arwen.pp.htv.fi>
 <20130308012833.GA16076@nchen-desktop>
 <20130308071832.GE21589@arwen.pp.htv.fi>
Message-ID: <20130308080555.GA22550@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 09:18:32AM +0200, Felipe Balbi wrote:
> > > 
> > > This isn't legal. If you want to make sure vbus is alive before
> > > connecting pullups, then do it generically. Modify udc-core.c to make
> > > those checks for you. Bypassing the framework is dangerous because
> > > whenever I wanna change something, I might miss your private details and
> > > end up causing regressions.
> > 
> > Let thing be generic is a good idea. Then, is it ok I post a patch let
> > udc manage pullup by itself (through a flag) just you did for uvc?
> > UDC core doesn't know VBUS, so the pullup can't be managed by udc core
> > totally.
> 
> then teach UDC core about VBUS. Send the patches and we will figure out
> if they can be applied or not.

I will do it

> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
