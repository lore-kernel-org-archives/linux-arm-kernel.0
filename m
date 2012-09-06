From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Sep 2012 15:31:38 +0300
Subject: [PATCH v3 20/23] serial: omap: fix software flow control
In-Reply-To: <20120905202749.GA2451@kroah.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-21-git-send-email-balbi@ti.com>
 <20120905202749.GA2451@kroah.com>
Message-ID: <20120906123136.GD29202@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 01:27:49PM -0700, Greg KH wrote:
> On Thu, Aug 23, 2012 at 01:33:00PM +0300, Felipe Balbi wrote:
> > From: Vikram Pandita <vikram.pandita@ti.com>
> > 
> > Software flow control register bits were not defined correctly.
> > 
> > Also clarify the IXON and IXOFF logic to reflect what userspace wants.
> > 
> > Cc: stable at vger.kernel.org
> > Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> 
> If this is a stable patch, should it be pulled out and put also in for
> 3.6?

I'll leave that for Vikram to answer. Vikram, do you think this is
something so extreme that we _must_ apply it now, or can it wait for the
next merge window ?

I mean, I think this bug has been in the driver for a long time, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120906/28a9f259/attachment-0001.sig>
