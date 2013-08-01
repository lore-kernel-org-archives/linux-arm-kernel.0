From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 01 Aug 2013 22:12:14 +0900
Subject: [PATCH v8 06/12] ARM: dts: Add description of System MMU of Exynos
 SoCs
In-Reply-To: <CAK9yfHyeOQZzf_3Nv-fmuYdZtL8dzZequdx2ZddnUyXDn66bOg@mail.gmail.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
 <CAK9yfHy2btp1W+5-GiVQnkffDnJ-CgqXuAjGktkiKYyf7kKQbQ@mail.gmail.com>
 <003e01ce8c31$41d0c450$c5724cf0$@samsung.com>
 <CAK9yfHyeOQZzf_3Nv-fmuYdZtL8dzZequdx2ZddnUyXDn66bOg@mail.gmail.com>
Message-ID: <003901ce8eb8$bdd877d0$39896770$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sachin Kamat [mailto:sachin.kamat at linaro.org]
> Sent: Monday, July 29, 2013 5:05 PM
> 
> On 29 July 2013 13:27, Cho KyongHo <pullip.cho@samsung.com> wrote:
> >> -----Original Message-----
> >> From: Cho KyongHo [mailto:pullip.cho at samsung.com]
> >> Sent: Monday, July 29, 2013 4:20 PM
> >>
> >> > -----Original Message-----
> >> > From: Sachin Kamat [mailto:sachin.kamat at linaro.org]
> >> > Sent: Monday, July 29, 2013 3:38 PM
> >> >
> >> > Hi KyongHo,
> >> >
> >> > On 26 July 2013 16:58, Cho KyongHo <pullip.cho@samsung.com> wrote:
> >> > > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> >> > > ---
> >> > >  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |  103 +++++++
> >> > >  arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++++++
> >> > >  arch/arm/boot/dts/exynos4210.dtsi                  |   25 ++
> >> > >  arch/arm/boot/dts/exynos4x12.dtsi                  |   76 +++++
> >> > >  arch/arm/boot/dts/exynos5250.dtsi                  |  291 ++++++++++++++++++++
> >> > >  5 files changed, 617 insertions(+), 0 deletions(-)
> >> > >  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> >> >
> >> > This patch does not apply on the mainline Linus' tree (3.11-rc2). Please rebase.
> >> >
> >>
> >> OK. I will rebase the next patches on that.
> >
> > I don't get any conflict both on the latest of Linus's tree (3.11-rc3)
> > and for-next branch  of Samsung git.
> > Can you show me the diff?
> >
> 
> I get the following error when I do git am on this patch (linus' tree
> 3.11-rc3). Other patches apply fine.
> 
> Applying: ARM: dts: Add description of System MMU of Exynos SoCs
> <local_path>/linux/.git/rebase-apply/patch:120: new blank line at EOF.
> +
> error: patch failed: arch/arm/boot/dts/exynos4.dtsi:161
> error: arch/arm/boot/dts/exynos4.dtsi: patch does not apply
> error: patch failed: arch/arm/boot/dts/exynos4210.dtsi:119
> error: arch/arm/boot/dts/exynos4210.dtsi: patch does not apply
> error: patch failed: arch/arm/boot/dts/exynos4x12.dtsi:79
> error: arch/arm/boot/dts/exynos4x12.dtsi: patch does not apply
> error: patch failed: arch/arm/boot/dts/exynos5250.dtsi:614
> error: arch/arm/boot/dts/exynos5250.dtsi: patch does not apply
> Patch failed at 0001 ARM: dts: Add description of System MMU of Exynos SoCs
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort".
> 

I wonder why you get the errors.
The error message shows the patch has extra blank line after the mark of EOF.
Or, maybe the patch I posted omitted some format information...

> --
> With warm regards,
> Sachin
