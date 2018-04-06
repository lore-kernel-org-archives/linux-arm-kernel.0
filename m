From: yamada.masahiro@socionext.com (yamada.masahiro at socionext.com)
Date: Fri, 6 Apr 2018 05:34:08 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and
 CONFIG_SNI_AVE
In-Reply-To: <243c6f13b7264e7881b5b06a9c8dca30@SOC-EX01V.e01.socionext.com>
References: <1522153269-21244-1-git-send-email-hayashi.kunihiko@socionext.com>
 <243c6f13b7264e7881b5b06a9c8dca30@SOC-EX01V.e01.socionext.com>
Message-ID: <dfd422d81f6f451da6f05685cbe7d506@SOC-EX01V.e01.socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
> yamada.masahiro at socionext.com
> Sent: Friday, April 06, 2018 2:31 PM
> To: arnd at arndb.de; arm at kernel.org
> Cc: olof at lixom.net; jaswinder.singh at linaro.org; Hayashi, Kunihiko/? ?
> ? <hayashi.kunihiko@socionext.com>; masami.hiramatsu at linaro.org;
> linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL
> and CONFIG_SNI_AVE
> 
> Hi Arnd,
> 
> > -----Original Message-----
> > From: Kunihiko Hayashi [mailto:hayashi.kunihiko at socionext.com]
> > Sent: Tuesday, March 27, 2018 9:21 PM
> > To: Russell King <linux@armlinux.org.uk>; Yamada, Masahiro/?? ??
> > <yamada.masahiro@socionext.com>; Olof Johansson <olof@lixom.net>; Arnd
> > Bergmann <arnd@arndb.de>; linux-arm-kernel at lists.infradead.org
> > Cc: arm at kernel.org; Masami Hiramatsu <masami.hiramatsu@linaro.org>;
> Jassi
> > Brar <jaswinder.singh@linaro.org>; Hayashi, Kunihiko/? ??
> > <hayashi.kunihiko@socionext.com>
> > Subject: [PATCH] ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL
> and
> > CONFIG_SNI_AVE
> >
> > Enable the thermal monitor driver and the AVE ethernet driver
> > implemented on UniPhier SoCs.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> 
> What has happened to this patch?
> 
> You picked up arch/arm64/config/defconfig one (commit d28db34a),
> but I am afraid you missed this one (arch/arm/configs/multi_v7_defconfig).
> 
> I do not have a strong opinion whether ethernet drivers should be built-in
> or modular,
> but I want to see consistency between arch/arm and arch/arm64
> for Socionext platform.
> 
> You accepted commit d28db34a anyway,
> so I hope you will pick up this one too.
> 
> 
> BTW, I do not see this patch in any ML at all.
> Probably, the sender of this patch, Kunihiko Hayashi,
> is not a subscriber of the ARM-linux ML, and he did not CC LKML either.

No.  Now I found this patch in ML.  Sorry.
