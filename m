From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 16 Dec 2015 13:55:11 +0100
Subject: [PATCH v3 4/4] drivers: psci: replace psci firmware calls
In-Reply-To: <20151216105529.GC19814@red-moon>
References: <1448449461-5043-1-git-send-email-jens.wiklander@linaro.org>
 <1448449461-5043-5-git-send-email-jens.wiklander@linaro.org>
 <20151201184741.GE29045@leverpostej> <20151201194421.GA29068@ermac>
 <20151216105529.GC19814@red-moon>
Message-ID: <20151216125509.GA27585@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 10:55:29AM +0000, Lorenzo Pieralisi wrote:
> [CC'ed Daniel]
> 
> On Tue, Dec 01, 2015 at 08:44:22PM +0100, Jens Wiklander wrote:
> 
> [...]
> 
> > > What's the plan for merging this? I assume this'll go via arm-soc?
> > 
> > I talked to Arnd about this and he suggested to go via Russel.
> 
> Heads-up, this patch will conflict with:
> 
> https://patchwork.kernel.org/patch/7418351/
> 
> that goes via linux-pm tree, please let me and Daniel know how
> you want us to sort this out.

I guess this arm-smccc patchset need to go together with that patch in
some way. I've just uploaded my patches in Russels patch system, but I
can stop that and try to go via the linux-pm tree instead if you think
the maintainer would accept that. I'll need to ask Russel if he can ack
the patches "arm/arm64: add arm-smccc" and
"arm: add implementation for arm-smccc" first though.

Would that work or do you have another idea? I'm of course happy either
way as long as the patches get through. I'm new to this so any advice is
appreciated.

Thanks,
Jens
