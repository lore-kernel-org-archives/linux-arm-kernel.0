From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 Sep 2012 19:39:18 +0900
Subject: [PATCH 0/3] ARM: dts: Exynos4 dts reorganization
References: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
 <CAJuYYwRWqvzw_MdLa7NfE9ppbPiz8=HTXUW+-mXedvu2GPQWBg@mail.gmail.com>
Message-ID: <04f501cd94c0$b0a61b00$11f25100$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Thomas Abraham wrote:
> >
> > On 3 September 2012 18:04, Tomasz Figa <t.figa@samsung.com> wrote:
> > > This patch series prepares existing Exynos4210 DT infrastructure to be
> > > further extended for new SoCs from Exynos4 line and new boards.
> > >
> > > Tomasz Figa (3):
> > >   ARM: dts: Move parts common to Exynos4 from Exynos4210.dtsi to
> > >     Exynos4.dtsi
> > >   ARM: EXYNOS: exynos4-dt: Use exynos4 prefix instead of exynos4210
> > >   ARM: dts: exynos4: Assume status of all optional nodes as disabled
> > >
> > >  arch/arm/boot/dts/exynos4.dtsi            | 232
> > ++++++++++++++++++++++++++++++
> > >  arch/arm/boot/dts/exynos4210-origen.dts   |  58 +-------
> > >  arch/arm/boot/dts/exynos4210-smdkv310.dts |  52 +------
> > >  arch/arm/boot/dts/exynos4210.dtsi         | 181
+----------------------
> > >  arch/arm/mach-exynos/mach-exynos4-dt.c    |  18 +--
> > >  5 files changed, 248 insertions(+), 293 deletions(-)
> > >  create mode 100644 arch/arm/boot/dts/exynos4.dtsi
> > >
> >
> > Thanks, we can build Exynos4412 device tree support on top of this
> series.
> >
> > Acked-by: Thomas Abraham <thomas.abraham@linaro.org>
> 
> Thomas, thanks for your ack on this series and I'm OK on this series.
> 
> But you know, Donjin Kim submitted almost same patch except gpio stuff one
> month before this series but needs to update something though. So would be
> nice if either Tomasz or Dongjin could ack on the other patch?
> 
Hmm...OK, I couldn't get any response from anyone so I will pick up this
patches. If any objection, please let me know.

Of course, if any regarding patches, need to work against on them.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
