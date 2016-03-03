From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 12:32:24 +0100
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.6 (#2)
In-Reply-To: <87si07lugm.fsf@free-electrons.com>
References: <87bn73o885.fsf@free-electrons.com> <2820325.orlLQWWEvZ@wuerfel>
 <87si07lugm.fsf@free-electrons.com>
Message-ID: <3410406.GdjOzf3Ru9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 11:35:53 Gregory CLEMENT wrote:
> 
>  On mar., mars 01 2016, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Friday 26 February 2016 15:29:46 Gregory CLEMENT wrote:
> >> mvebu defconfig for 4.6 (part 2)
> >> 
> >> enable SRAM support in mvebu_v7_defconfig
> >> 
> >> 
> >
> > Merged into next/defconfig.
> >
> > I see that the SRAM support is not enabled in multi_v7_defconfig, can
> > you enable that as well?
> 
> Actually it is already selected by CONFIG_ARCH_EXYNOS so there is no
> need to add it in multi_v7_defconfig.

Ok, I see.

	Arnd
