From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Jan 2014 09:09:29 +0900
Subject: Samsung-clk patches for 3.15
In-Reply-To: <52E6EDC1.9080003@gmail.com>
References: <52E27AE9.7040501@samsung.com> <52E6EDC1.9080003@gmail.com>
Message-ID: <251c01cf1bbd$36802390$a3806ab0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> [Forgot to Cc Mike...]
> 
> On 24.01.2014 15:38, Tomasz Figa wrote:
> > Hi,
> >

Hi,

> > Linux 3.14 is going to include Andrzej Hajda's patches converting
> > Samsung clock drivers to use clock ID defines in include/dt-bindings,
> > instead of local enums, but to avoid unnecessary merge conflicts we
> > have converted only the clock driver, leaving DTS files unchanged yet.
> >
> > We intend to complete the conversion in 3.15, by replacing magic
> > numbers in DTS files with respective preprocessor macros, but to
> > reduce potential conflicts we need help of you, Samsung clock patches
> authors :).
> >
> > I'd like to ask anybody who already has patches for DTS files adding
> > any clock-related contents still using numeric IDs, e.g. clock
> > properties in nodes or full nodes containing clock properties, to make
> > sure that the patches are merged before Andrzej sends the conversion
> > patches. Then Andrzej's script will generate patches updating all
> > clock properties, leaving no numeric IDs in DTS files.
> >

There are several DTS patches in v3.14-drop/soc-exynos-2 branch of my tree
for 3.15 and it will be merged after done of multiplatform, I need to rebase
them based on v3.14-rc1 though...So I think, would be better if we could
update DTS with using Andrzej's script after merging it into arm-soc...

> > If you are just starting your work on a patch that introduces changes
> > as mentioned above, please make sure to already use clock macros, not
> > numeric IDs. Otherwise you risk having needless rebases with a lot of
> > conflicts. You have been warned ;).
> >

Thanks,
Kukjin
