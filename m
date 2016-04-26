From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 26 Apr 2016 11:42:53 +0100
Subject: [PATCH 08/18] ARM: multi_v7_defconfig: Enable STi FDMA driver
In-Reply-To: <5937696.Zdx8BrBD6K@wuerfel>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-9-git-send-email-peter.griffin@linaro.org>
 <5937696.Zdx8BrBD6K@wuerfel>
Message-ID: <20160426104253.GB2984@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, 21 Apr 2016, Arnd Bergmann wrote:

> On Thursday 21 April 2016 12:04:25 Peter Griffin wrote:
> > This DMA controller is found on all STi chipsets.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > index 2823490..61008a0 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -727,6 +727,7 @@ CONFIG_DMA_OMAP=y
> >  CONFIG_QCOM_BAM_DMA=y
> >  CONFIG_XILINX_VDMA=y
> >  CONFIG_DMA_SUN6I=y
> > +CONFIG_ST_FDMA=y
> >  CONFIG_STAGING=y
> >  CONFIG_SENSORS_ISL29018=y
> >  CONFIG_SENSORS_ISL29028=y
> > -- 
> 
> Is this needed for booting? If not, make it a loadable module.

No it isn't required for booting. Will fix in v4.

Peter
