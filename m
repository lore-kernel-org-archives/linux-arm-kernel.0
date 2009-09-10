From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 10 Sep 2009 13:54:39 +0200
Subject: What's inside the pxa tree for this merge window
In-Reply-To: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
References: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
Message-ID: <20090910115439.GU9410@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 07:46:26PM +0800, Eric Miao wrote:
> Daniel Mack (6):
>       [ARM] pxa: add MFP_PULL_FLOAT
>       [ARM] pxa: add clock definition for graphics controller
>       [ARM] pxa: add device definition for graphics controller
>       [ARM] pxa: rename GCU IRQ for consistency

Regarding the PXA3xx GCU driver:

I really wonder what's wrong with the fbdev people to ignore my very
simple patch for pxa3xx gcu enabling (not the gcu driver itself but just
the acceleration ID registration), even after the fifth (or so)
repost.

We've been using this driver for quite some time now. There's a small
bug hiding somewhere which we are currently trying to sort out, but
that's most probably not in the kernel driver but in the DirectFB part.
It would, however, be much easier for people to help testing if the
driver was upstream.

Is there any way to push things a little? Except for that one bug, the
driver is a huge benefit for any PXA3xx application with graphical user
interface, so I'd really like to see it mainline. The sooner the better.

Thanks,
Daniel
