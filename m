From: horms@verge.net.au (Simon Horman)
Date: Thu, 16 Jan 2014 09:50:29 +0900
Subject: [PATCH] ARM: shmobile: Break out R-Car SYSC PM code
In-Reply-To: <87txd47od8.wl%kuninori.morimoto.gx@gmail.com>
References: <20140115074308.8471.64824.sendpatchset@w520>
 <20140115083027.GC16455@verge.net.au>
 <CANqRtoQ8sLLXQWKHaxbFpSb+3oBF2Spn_nUZx91OWsmb_+kMnA@mail.gmail.com>
 <87txd47od8.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <20140116005027.GG12550@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 04:37:58PM -0800, Kuninori Morimoto wrote:
> 
> Hi Magnus, Simon
> 
> > >> Break out the R-Car SYSC power management code from
> > >> the r8a7779 SoC code. With this new shared R-Car SYSC
> > >> code base it is possible to hook in Generation 2 SoCs
> > >> as well.
> > >
> > > Is this also useful for the r8a7778 (the other Gen 1 SoC in mainline) ?
> > 
> > I don't know actually. =) What does Morimoto-san say about this?
> 
> Thank you for this patch.
> it is useful, but, unfortunately r8a7778 (= M1) doesn't have SYSC

Thanks, one less thing to worry about :)
