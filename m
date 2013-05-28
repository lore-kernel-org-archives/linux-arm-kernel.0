From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 May 2013 17:48:03 +0100
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <20130528162715.GB28253@arwen.pp.htv.fi>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
 <CACRpkdYjjDp+7hzGtAchyy3+5Vxc8jK5THGCETkAO_V9Hj9Ssw@mail.gmail.com>
 <20130528162715.GB28253@arwen.pp.htv.fi>
Message-ID: <20130528164803.GA3012@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe

> > > For all ux500 based platforms the maximum number of end-points are used.
> > > Move this knowledge into the driver so we can relinquish the burden from
> > > platform data. This also removes quite a bit of complexity from the driver
> > > and will aid us when we come to enable the driver for Device Tree.
> > >
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Cc: linux-usb at vger.kernel.org
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > I guess this stuff is dependent on the stuff Fabio has recently sent to
> > Felipe for the ux500 musb DMA so these musb patches should
> > primarily go through his tree.
> > 
> > It seems like the later changes to the platform code
> > (arch/arm/mach-ux500) may be sufficiently orthogonal
> > so it can be done out-of-order?
> > 
> > I can't merge any of this without Felipes ACKs in any
> > case.
> 
> Do you want to take this yourself ? I haven't fully read the series yet,
> but seems like this depends on the rest of the series. If you want to
> take it, let me know I can ack the patches as soon as I'm done
> reviewing.

Yes that would be ideal, if you wouldn't mind.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
