From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 May 2012 16:47:32 +0900
Subject: [GIT PULL] Samsung devel-1 for v3.5
In-Reply-To: <CAOesGMhwEpQstrM5Zc4ie=CX2BAoSsfAvJbZYxUpg66NUnxrjw@mail.gmail.com>
References: <4FAF0156.5080306@samsung.com>
 <CAOesGMhwEpQstrM5Zc4ie=CX2BAoSsfAvJbZYxUpg66NUnxrjw@mail.gmail.com>
Message-ID: <064f01cd31a5$d2300660$76901320$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Sat, May 12, 2012 at 5:33 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Hi Arnd, Olof
> >
> > Please pull Samsung devel for v3.5
> >
> > This is including exynos/iommu, platform of drm and fimc-lite, dma for
> > exynos5250 and s3c24xx-hsspi.
> >
> > Note, the exynos/iommu patch got the ack from Joerg and this should be
> sent
> > to upstream via arm tree and since it depends on cleanup-samsung-iommu,
> the
> > cleanup branch is included(merged) in here.
> >
> > If any problems, please let me know.
> 
> Same here, I'll hold off pulling this until we've sorted out the
> cleanup-samsung-iommu request.
> 
Please hold this off for a moment because I need to sort out regarding
s3c-hsotg patches which cause build error because some patches have been
already in usb tree for it.

If required, I will send separate branch to you.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
