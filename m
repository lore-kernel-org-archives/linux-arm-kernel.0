From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Oct 2012 20:22:10 +0900
Subject: [PATCH v2] ASoC: Samsung: Update Kconfig for Exynos5250 and
 Exynos4412
In-Reply-To: <50658325.8050704@linaro.org>
References: <1348741777-29569-1-git-send-email-padma.v@samsung.com>
 <003401cd9d5f$179495c0$46bdc140$@samsung.com> <50658325.8050704@linaro.org>
Message-ID: <01ca01cdb110$a48783b0$ed968b10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera wrote:
> 
> On 09/28/2012 03:23 PM, Sangsu Park wrote:
> >
> > On Thu, Sep 27, 2012 at 07:30 PM, Padmavathi Venna wrote:
> >

[...]

> >> @@ -63,7 +63,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
> >>
> >>  config SND_SOC_SAMSUNG_SMDK_WM8994
> >>  	tristate "SoC I2S Audio support for WM8994 on SMDK"
> >> -	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 ||
> >> MACH_SMDK4212)
> >> +	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 ||
> >> MACH_SMDK4212 || MACH_SMDK4412 || MACH_EXYNOS5_DT)
> >>  	depends on I2C=y && GENERIC_HARDIRQS
> >>  	select MFD_WM8994
> >>  	select SND_SOC_WM8994
> >
> > I'm not sure about this since MACH_EXYNOS5_DT can have others instead of
> SMDK.
> >
> 
> But there is no other way we can differentiate between two EXYNOS5_DT
> based boards in the kernel. So, support for all possible codecs and
> sound-cards should be enabled in the kernel. The instantiation of the
> drivers should depend on the device-tree entries.
> 
Hmm...any idea on this?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
