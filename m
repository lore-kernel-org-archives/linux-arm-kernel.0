From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 27 Nov 2013 18:58:51 -0500
Subject: [PATCH] dma: mv_xor: remove mv_desc_get_dest_addr()
In-Reply-To: <CAOesGMhRYg4L72v8XCCSwSnLhYuZ6+aBTxPGNvVn=n=xpVm71A@mail.gmail.com>
References: <1385408365-8072-1-git-send-email-jason@lakedaemon.net>
 <20131125194631.GE2879@titan.lakedaemon.net>
 <CAOesGMhRYg4L72v8XCCSwSnLhYuZ6+aBTxPGNvVn=n=xpVm71A@mail.gmail.com>
Message-ID: <20131127235851.GS2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 11:45:24AM -0800, Olof Johansson wrote:
> On Mon, Nov 25, 2013 at 11:46 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Mon, Nov 25, 2013 at 07:39:25PM +0000, Jason Cooper wrote:
> >> The following commit:
> >>
> >>   54f8d501e842 dmaengine: remove DMA unmap from drivers
> >>
> >> removed the last caller to mv_desc_get_dest_addr(), creating the
> >> warning:
> >>
> >>   drivers/dma/mv_xor.c:57:12: warning: 'mv_desc_get_dest_addr' defined
> >>   but not used [-Wunused-function]
> >>
> >> Remove it.
> >>
> >> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> >> ---
> >>  drivers/dma/mv_xor.c | 6 ------
> >>  1 file changed, 6 deletions(-)
> >
> > Gah!  I sent too fast.  I meant to mention that I have this in my
> > mvebu/fixes branch, which gets merged into -next each night.  (The
> > warning was bugging me :) )
> >
> > Just let me know when you take it and I'll drop it from my branches.
> 
> Hmm. Please don't add patches for other subsystems into your -next
> tree, since then there is no indication for those of us who follow
> -next that the patch is not yet merged by the appropriate maintainer.

Ack.  Dropped.  Sorry for the confusion and thanks for setting me
straight.

thx,

Jason.
