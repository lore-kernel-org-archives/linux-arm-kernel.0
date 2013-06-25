From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 23:05:06 +0200
Subject: [PATCH 1/4] usb: gadget: s3c-hsotg: Allow driver instantiation
 using device tree
In-Reply-To: <20130625210044.GD9748@arwen.pp.htv.fi>
References: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
 <5782443.xpFZv1Saq0@flatron> <20130625210044.GD9748@arwen.pp.htv.fi>
Message-ID: <1543279.BFn8pxUra6@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 of June 2013 00:00:44 Felipe Balbi wrote:
> On Tue, Jun 25, 2013 at 10:57:06PM +0200, Tomasz Figa wrote:
> > On Tuesday 25 of June 2013 23:46:32 Felipe Balbi wrote:
> > > On Tue, Jun 25, 2013 at 05:38:23PM +0200, Tomasz Figa wrote:
> > > > This patch adds OF match table to the driver to allow
> > > > instantiating it
> > > > using device tree.
> > > > 
> > > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > 
> > > when will this driver get merged into dwc2 ?
> > 
> > What's dwc2? I can only see dwc3 in mainline kernel tree and it
> > doesn't
> > seem to be compatible with s3c-hsotg.
> 
> drivers/staging/dwc2/

Oh right, staging, I forgot to check there.

> That's the same IP you're using Paul Zimmerman (now in Cc) is working
> towards getting that out of staging. It currently has only host mode, so
> plugging your code in there shouldn't be too difficult.
> 
> OTOH, it might be better to make your code a device-only version of dwc2
> (drivers/usb/dwc2) and have Paul move his host side to that instead.

Hmm, I believe Lukasz Majewski and Marek Szyprowski (both on CC) should be 
able to say something more on this topic as I'm not really into USB 
drivers and just doing Device Tree enablement here.

Best regards,
Tomasz
