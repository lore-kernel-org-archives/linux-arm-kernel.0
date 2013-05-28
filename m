From: balbi@ti.com (Felipe Balbi)
Date: Tue, 28 May 2013 19:27:15 +0300
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <CACRpkdYjjDp+7hzGtAchyy3+5Vxc8jK5THGCETkAO_V9Hj9Ssw@mail.gmail.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
 <CACRpkdYjjDp+7hzGtAchyy3+5Vxc8jK5THGCETkAO_V9Hj9Ssw@mail.gmail.com>
Message-ID: <20130528162715.GB28253@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 15, 2013 at 07:18:01PM +0200, Linus Walleij wrote:
> On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > For all ux500 based platforms the maximum number of end-points are used.
> > Move this knowledge into the driver so we can relinquish the burden from
> > platform data. This also removes quite a bit of complexity from the driver
> > and will aid us when we come to enable the driver for Device Tree.
> >
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: linux-usb at vger.kernel.org
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I guess this stuff is dependent on the stuff Fabio has recently sent to
> Felipe for the ux500 musb DMA so these musb patches should
> primarily go through his tree.
> 
> It seems like the later changes to the platform code
> (arch/arm/mach-ux500) may be sufficiently orthogonal
> so it can be done out-of-order?
> 
> I can't merge any of this without Felipes ACKs in any
> case.

Do you want to take this yourself ? I haven't fully read the series yet,
but seems like this depends on the rest of the series. If you want to
take it, let me know I can ack the patches as soon as I'm done
reviewing.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130528/eab373a0/attachment.sig>
