From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:16:04 -0800
Subject: [GIT PULL] ARM: EXYNOS: SROM driver for v4.6, 2nd try
In-Reply-To: <2210448.V5gsMerLz6@wuerfel>
References: <1456825042-23733-1-git-send-email-k.kozlowski@samsung.com>
 <1456825042-23733-3-git-send-email-k.kozlowski@samsung.com>
 <56D77FA6.5070500@samsung.com> <2210448.V5gsMerLz6@wuerfel>
Message-ID: <20160313011604.GL17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 02:11:32PM +0100, Arnd Bergmann wrote:
> On Thursday 03 March 2016 09:04:54 Krzysztof Kozlowski wrote:
> > On 01.03.2016 18:37, Krzysztof Kozlowski wrote:
> > > Hi,
> > > 
> > > 
> > > After Olof comments, second pull request with movement of SROM code
> > > to separate driver - under drivers/memory/samsung (more are planned for
> > > that directory).
> > > 
> > > This depends on (included here):
> > > 1. tag samsung-dt-srom-4.6: SROM-DT changes, merged already to arm-soc,
> > > 2. tag samsung-soc-4.6-2: next/soc changes, sent few days ago, not merged yet.
> > > 
> > > This may conflict in the future (in linux-next or Linus) around
> > > drivers/memory/Kconfig with iommu tree. Just add all the changes.
> > > 
> > > 
> > > The diff at the end contains both samsung-soc-4.6-2 and this stuff.
> > > To make finding changes easier, below you will find difference between
> > > this tag and samsung-soc-4.6-2:
> > 
> > I see you did not pull this yet so can you wait a little bit? Rob
> > Herring posted some comments on bindings so this might be revisited...
> > 
> > This is an unlucky patchset...
> 
> It was a bit late last night, and I didn't want to check that the
> dependencies were correct. I also saw that you had discussed these
> contents with Olof before, but didn't follow the thread there, so
> I was hoping that Olof could get back to it and check that his
> concerns are all addressed before picking it up.

Hi,

I've merged the other SoC branches now (that were respun without this SROM
contents). I think it's safe given the feedback from Rob to wait with this
driver for the next cycle. That way the dependencies are gone too since they
will have been merged.


-Olof
