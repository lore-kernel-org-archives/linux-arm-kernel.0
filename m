From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 24 Mar 2015 21:52:10 +0900
Subject: [PATCH 1/1] ARM: exynos_defconfig: Enable HDMI support
In-Reply-To: <CABxcv==Ko2PUfwuo8D2JDL4iR4+VGvewQpR_RDh9pB4Qbg5c=g@mail.gmail.com>
References: <1423244567-24463-1-git-send-email-javier.martinez@collabora.co.uk>
 <CABxcv=mMD=X=EKOC2sGXcDwMeOmoO6cmVAu=roV_AVqUwG+pXg@mail.gmail.com>
 <CABxcv==Ko2PUfwuo8D2JDL4iR4+VGvewQpR_RDh9pB4Qbg5c=g@mail.gmail.com>
Message-ID: <02b201d06631$58129d70$0837d850$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canilla wrote:
> 
> Hello Kukjin,
> 
Hi,

> On Tue, Mar 17, 2015 at 7:54 PM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
> > On Fri, Feb 6, 2015 at 6:42 PM, Javier Martinez Canillas
> > <javier.martinez@collabora.co.uk> wrote:
> >> Many Exynos boards have an HDMI port so enable Exynos DRM HDMI support.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >> ---
> >>
> >> Exynos DRM HDMI has some issues that were fixed by Andrzej's [0] series.
> >> So now is safe to HDMI support for Exynos boards.
> >>
> >> [0]: https://lkml.org/lkml/2015/2/5/265
> >>
> >>  arch/arm/configs/exynos_defconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> >> index 70e5d0bdb4e4..e44da52e5223 100644
> >> --- a/arch/arm/configs/exynos_defconfig
> >> +++ b/arch/arm/configs/exynos_defconfig
> >> @@ -120,6 +120,7 @@ CONFIG_REGULATOR_S2MPS11=y
> >>  CONFIG_REGULATOR_S5M8767=y
> >>  CONFIG_REGULATOR_TPS65090=y
> >>  CONFIG_DRM=y
> >> +CONFIG_DRM_EXYNOS_HDMI=y
> >>  CONFIG_DRM_BRIDGE=y
> >>  CONFIG_DRM_PTN3460=y
> >>  CONFIG_DRM_PS8622=y
> >> --
> >
> > It seems you missed this patch when picking the exynos_defconfig patches.
> >
> 
> Another gentle reminder about this patch.
> 
Thanks, will apply tonight ;-)

- Kukjin
