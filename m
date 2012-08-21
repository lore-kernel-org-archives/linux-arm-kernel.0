From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 13:34:39 +0300
Subject: [RFC/PATCH 05/13] serial: omap: drop DMA support
In-Reply-To: <CAMQu2gyGVhB63rn+G6B3nFLki5ib40C_2o2Bh1mBd8sw8wT_Ng@mail.gmail.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345540555-24359-6-git-send-email-balbi@ti.com>
 <CAMQu2gw93ES=u9J1FfWK_CKkgUq8V487+tmKtQ34p8O7VJ6aHA@mail.gmail.com>
 <20120821102045.GL10347@arwen.pp.htv.fi>
 <CAMQu2gyGVhB63rn+G6B3nFLki5ib40C_2o2Bh1mBd8sw8wT_Ng@mail.gmail.com>
Message-ID: <20120821103438.GQ10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 04:05:22PM +0530, Shilimkar, Santosh wrote:
> On Tue, Aug 21, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Tue, Aug 21, 2012 at 03:14:19PM +0530, Shilimkar, Santosh wrote:
> >> On Tue, Aug 21, 2012 at 2:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> >> > The current support is known to be broken and
> >> > a later patch will come re-adding it using
> >> > dma engine API.
> >> >
> >> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> > ---
> >> Thanks Felipe !!
> >
> > no problem.
> >
> >> One less driver now towards OMAP DMA
> >> engine conversion.
> >
> > indeed :-) I'll take a closer look into rx timeout IRQ, but it looks
> > like we can use it to kick dma only for "big" transfers... need to play
> > with it for a while first, though.
> >
> Yep. The RX path with DMA is bit of difficult part to manage for
> UART.
> 
> >> FWIW,
> >> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >
> > is this Ack for this patch only or the entire series ??
> >
> Two more patches to review and then I will do it for
> full series on top of the cover-letter :-)

cool, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/7ee6a1ca/attachment.sig>
