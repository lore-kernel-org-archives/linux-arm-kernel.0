From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 13 Jun 2012 14:23:04 +0800
Subject: [PATCH v4] usb: chipidea: permit driver bindings pass phy pointer
In-Reply-To: <20120612231438.GA6177@kroah.com>
References: <1337912665-16615-3-git-send-email-richard.zhao@freescale.com>
 <1339159026-15837-1-git-send-email-richard.zhao@freescale.com>
 <20120612231438.GA6177@kroah.com>
Message-ID: <20120613062031.GB22680@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 04:14:38PM -0700, Greg KH wrote:
> On Fri, Jun 08, 2012 at 08:37:06PM +0800, Richard Zhao wrote:
> > Sometimes, the driver bindings may know what phy they use.
> > For example, when using device tree, the usb controller may have a
> > phandler pointing to usb phy.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Reviewed-by: Marek Vasut <marex@denx.de>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> > ---
> > Changes since laster version:
> > - hcd transceiver renamed to phy
> 
> Ick, I see patches all over this thread, and other threads, and I have
> no idea what to apply anywhere...
I thought it only need small fix, but the fix became bigger and bigger.
> 
> So, consider all chipidea patches dropped from my queue now, can you
> please resend them to me, with the accumulated acks and reviewed-by
> line, so that I can queue them up?
I'll send out a new version series.

Thanks for review.
Richard
> 
> thanks,
> 
> greg k-h
> 
