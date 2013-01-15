From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue, 15 Jan 2013 09:55:00 +0100
Subject: [GIT PULL] ste_dma40 updates for 3.9
In-Reply-To: <CAOesGMg6FqsaqZiGeK14n4==dF-y=iMYSGRDBYSwkGWO0J69Yg@mail.gmail.com>
References: <20130114101542.GA5363@balto.lan>
 <CAOesGMg6FqsaqZiGeK14n4==dF-y=iMYSGRDBYSwkGWO0J69Yg@mail.gmail.com>
Message-ID: <20130115085500.GA18406@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On Mon, Jan 14, 2013 at 10:48:15PM -0800, Olof Johansson wrote:
> > This contains a series of updates and fixes for the ste_dma40 driver.
> >
> > The driver is specific for the ux500, and the patches were acked by both Linus
> > Walleij, and Vinod Koul (dmaengine), who agreed to push this through arm-soc.
> >
> > Can you please pull those in for -next?
> 
> While I don't mind taking this through arm-soc, I don't see a strong
> reason to do so?
> 
> This series of patches only modify the ste_dma40 driver, there are no
> corresponding changes under arch/arm that need to be coordinated or
> considered w.r.t. merge conflicts. I.e. they all seem nicely isolated
> to only the driver.
> 
> So is there a specific reason for why these shouldn't just go in
> through the dmaengine tree?

The idea was to have this in the same tree as other ux500 specific
driver patches to easy up testing a bit, but now that you point it out
I see that current arm-soc tree is pretty clear of driver patches (mmci
was what I had in mind) and those should end up to other trees anyway,
so you're probably right and these should go in dmaengine tree.

Vinod, would you please consider pulling these into dmaengine's next
tree?

Thanks,
Fabio

-- 
Fabio Baltieri
