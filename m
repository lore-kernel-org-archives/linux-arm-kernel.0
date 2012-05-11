From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 11 May 2012 14:58:01 +0530
Subject: [GIT PULL] ep93xx fixes for 3.5
In-Reply-To: <CAOesGMjC0J_7NRQWrOkRNqrBbvKoBs3VJPOSSv5P4hqwpAE=OA@mail.gmail.com>
References: <4FAC6548.5060008@gmail.com>
 <CAOesGMjC0J_7NRQWrOkRNqrBbvKoBs3VJPOSSv5P4hqwpAE=OA@mail.gmail.com>
Message-ID: <1336728481.15424.1905.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-10 at 23:15 -0700, Olof Johansson wrote:
> Hi,
> 
> On Thu, May 10, 2012 at 6:03 PM, Ryan Mallon <rmallon@gmail.com> wrote:
> > The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:
> >
> >  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)
> >
> > are available in the git repository at:
> >
> >  git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-fixes-for-3.5
> >
> > for you to fetch changes up to 2b3c83efc9a653af6a24799eeb1a2900ba0439e6:
> >
> >  dmaengine/ep93xx_dma: Implement double buffering for M2M DMA channels (2012-04-20 08:37:19 +1000)
> >
> > ----------------------------------------------------------------
> > Rafal Prylowski (2):
> >      arm: ep93xx: Don't try to release not acquired GPIO lines
> >      dmaengine/ep93xx_dma: Implement double buffering for M2M DMA channels
> 
> Technically, this is a feature, not a fix. I also didn't see an ack
> from the DMA maintainer on it since it would normally go in through
> his tree.
> 
> Vinod, you OK with this coming through arm-soc? Looks fairly
> uncontroversial so it shouldn't be a big deal but I don't know if it
> might collide with anything else you have queued up.
Looks okay to me.
For: dmaengine/ep93xx_dma: Implement double buffering for M2M DMA
channels

Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
