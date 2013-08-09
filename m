From: pullip.cho@samsung.com (Cho KyongHo)
Date: Fri, 09 Aug 2013 11:24:36 +0900
Subject: [PATCH v8 06/12] ARM: dts: Add description of System MMU of Exynos
 SoCs
In-Reply-To: <20130808214343.GA19383@mudshark.cambridge.arm.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
 <003801ce8eb7$d7647f10$862d7d30$@samsung.com>
 <CAL_Jsq+_5GekzXpjWrtKZi2jWuxHSJxkPmVC4zmakfjAYai=eA@mail.gmail.com>
 <5354557.DijgoUKjW2@flatron>
 <20130808214343.GA19383@mudshark.cambridge.arm.com>
Message-ID: <20130809112436.8e44545cd503ca5a2b55a8cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 08 Aug 2013 22:43:43 +0100, Will Deacon wrote:
> On Thu, Aug 08, 2013 at 10:38:10PM +0100, Tomasz Figa wrote:
> > On Thursday 08 of August 2013 08:09:49 Rob Herring wrote:
> > > On Thu, Aug 1, 2013 at 8:05 AM, Cho KyongHo <pullip.cho@samsung.com> 
> > wrote:
> > > > Should this align with ARM System MMU bindings?
> > > > System MMU in Exynos SoC is different from ARM System MMU.
> > > > It does not follows the specifications of ARM System MMU.
> > > 
> > > I'm not saying the h/w is the same or even the same spec, but how you
> > > describe a master to iommu connection needs to be done in the same
> > > way. This should be done in the same way for ALL iommu's. And if what
> > > is defined does not work for you, then we need to understand that and
> > > fix the binding now.
> > 
> > +1
> > 
> > All IOMMUs should use a generic IOMMU Device Tree bindings (and in 
> > general, the same should be true for all Device Tree bindings).
> > 
> > This means that if we already have some bindings for IOMMU, then they 
> > should be reused if possible or extended if there is anything missing.
> > 
> > Of course there might be things that such generic bindings can't specify. 
> > In this case device-specific properties can be introduced, but this is 
> > last resort.
> 
> I'm also happy to discuss and/or review bindings in light of what we did for
> the ARM SMMU.
> 
> Will

Rob, I now understood what you are talking about.
Do you mean the binding description is lack of details about connection
betwen  System MMU and its master?

thanks.

KyongHo.
