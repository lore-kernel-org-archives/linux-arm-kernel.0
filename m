From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Nov 2012 13:53:20 +0900
Subject: [PATCH v3 0/4] ARM: EXYNOS: Power domain DT support extension
In-Reply-To: <1552856.8ocEO5iISn@amdc1227>
References: <1352811115-1198-1-git-send-email-t.figa@samsung.com>
 <1552856.8ocEO5iISn@amdc1227>
Message-ID: <0b6e01cdc6da$f6b723e0$e4256ba0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi,
> 
> On Tuesday 13 of November 2012 13:51:51 Tomasz Figa wrote:
> > This patch series fixes two issues with existing DT support for Exynos
> > power domains and extends it with the ability of binding devices to
> > domains, basically making it possible to use power domains with DT.
> >
> > Based on for-next branch of Kgene's tree.
> >
> > Changes since v2:
> >  - Rebased to for-next of Kgene's tree.
> > Changes since v1:
> >  - Added "samsung," prefix to "power-domain" property.
> >  - Added power domain nodes to Exynos4 device tree sources.
> >
> > Tomasz Figa (4):
> >   ARM: EXYNOS: pm_domain: Detect domain state on registration from DT
> >   ARM: EXYNOS: pm_domain: Fix power domain name initialization
> >   ARM: EXYNOS: pm_domain: Bind devices to power domains using DT
> >   ARM: dts: exynos4: Set up power domains
> >
> >  .../bindings/arm/exynos/power_domain.txt           | 15 +++-
> >  arch/arm/boot/dts/exynos4.dtsi                     | 30 +++++++
> >  arch/arm/boot/dts/exynos4210.dtsi                  |  5 ++
> >  arch/arm/mach-exynos/pm_domains.c                  | 93
> > +++++++++++++++++++++- 4 files changed, 135 insertions(+), 8
> > deletions(-)
> 
> Sorry, please disregard this series, as I have sent wrong version by
> mistake.
> 
> I will send correct one later.
> 
OK.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
