From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 21 May 2013 11:43:13 -0400
Subject: [PATCH 6/9] arm: mvebu: move cache and mvebu-mbus
 initialization later
In-Reply-To: <20130521173707.5a49eaec@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130521141621.GU31290@titan.lakedaemon.net>
 <20130521173707.5a49eaec@skate>
Message-ID: <20130521154313.GV31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, May 21, 2013 at 05:37:07PM +0200, Thomas Petazzoni wrote:
> On Tue, 21 May 2013 10:16:21 -0400, Jason Cooper wrote:
> > This doesn't apply when based on mvebu/cleanup because of:
> > 
> >   49ed97f ARM: Orion: Remove redundant init_dma_coherent_pool_size()
> 
> Right.
> 
> > I tried hacking it up to put it in mvebu/soc-internal_regs for a few
> > rounds of testing in linux-next during review, however, I'd prefer you
> > rebase this on top of mvebu/cleanup.
> 
> So you mean my next version of the "Internal registers switch" should
> be based on mvebu/cleanup, right?

Yes, sorry I wasn't clear, I meant the series.  You can drop 1-3 as
well for the next version, since I've pulled those.

> There will be some next version in any case, because I just found a
> bug in the latest patch when booting from a bootloader that has
> already done the switch to 0xF1.

Ok, I'll hold off putting it up for testing until v2.

thx,

Jason.
