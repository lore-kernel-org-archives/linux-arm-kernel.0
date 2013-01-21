From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon, 21 Jan 2013 09:36:53 +0100
Subject: [GIT PULL] ste_dma40 updates for 3.9
In-Reply-To: <20130120140733.GH23398@intel.com>
References: <20130114101542.GA5363@balto.lan>
 <CAOesGMg6FqsaqZiGeK14n4==dF-y=iMYSGRDBYSwkGWO0J69Yg@mail.gmail.com>
 <CACRpkdZh=5FBDCuSFWYw8t-1Snm1xuS_EyVTUyQ-8kwVgjWuPA@mail.gmail.com>
 <20130115191450.GA28615@quad.lixom.net>
 <20130120140733.GH23398@intel.com>
Message-ID: <20130121083653.GA8581@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 20, 2013 at 06:07:33AM -0800, Vinod Koul wrote:
> On Tue, Jan 15, 2013 at 11:14:50AM -0800, Olof Johansson wrote:
> > On Tue, Jan 15, 2013 at 09:53:05AM +0100, Linus Walleij wrote:
> > > On Tue, Jan 15, 2013 at 7:48 AM, Olof Johansson <olof@lixom.net> wrote:
> > > 
> > > > This series of patches only modify the ste_dma40 driver, there are no
> > > > corresponding changes under arch/arm that need to be coordinated or
> > > > considered w.r.t. merge conflicts. I.e. they all seem nicely isolated
> > > > to only the driver.
> > > >
> > > > So is there a specific reason for why these shouldn't just go in
> > > > through the dmaengine tree?
> > > 
> > > One reason would be if there are DMA bindings to device tree coming
> > > this merge window, as I'm told, and it implicates a lot of platform code
> > > changes on top of this as we adopt to it.
> > > 
> > > But maybe this will be wholly confined to the DMAengine tree?
> > 
> > Changing platform code in the driver trees is asking for conflicts at
> > merge time and a grumpy Linus, I'd prefer to merge arch/arm/* through
> > arm-soc in that case.
> > 
> > Either way, this branch can be merged into dmaengine as a branch pull,
> > and if needed we can bring it in as a dependency on arm-soc. We would
> > need the same for the dmaengine DT bindings branch as a base. Of course,
> > that requires that Vinod doesn't rebase his branch and keeps the merge
> > intact. Vinod, is that compatible with your workflow?
> Yes it is.
> 
> Is this series dependent on dmaengine dt-bindings. If so then it wont apply to
> arm tree. Btw I dont mind it getting merged to any of the trees as long as we
> keep dependecies and avoid major conflicts :)

So, would you accept my original pull-request in the dmaengine tree?

Thanks,
Fabio

-- 
Fabio Baltieri
