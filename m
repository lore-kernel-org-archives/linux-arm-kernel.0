From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 6 Aug 2013 08:18:27 +0100
Subject: [PATCH v3 07/22] ARM: dts: Remove '0x's from Exynos4210 DTSI file
In-Reply-To: <51FFE9F0.1000100@samsung.com>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-7-git-send-email-lee.jones@linaro.org>
 <20130724150937.GO26801@laptop> <51FFE9F0.1000100@samsung.com>
Message-ID: <20130806071827.GB5100@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Aug 2013, Kukjin Kim wrote:

> On 07/25/13 00:09, Lee Jones wrote:
> >... for the sake of consistency and assumed convention.
> >
> >Cc: Kukjin Kim<kgene.kim@samsung.com>
> >Cc: linux-samsung-soc at vger.kernel.org
> >Signed-off-by: Lee Jones<lee.jones@linaro.org>
> >
> >diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> >index b7f358a..53e2527 100644
> >--- a/arch/arm/boot/dts/exynos4210.dtsi
> >+++ b/arch/arm/boot/dts/exynos4210.dtsi
> >@@ -72,7 +72,7 @@
> >                 };
>    ^^^^^^^^^^^^^^^^
> >         };
>    ^^^^^^^^
> >
> >-       clock: clock-controller at 0x10030000 {
>    ^^^^^^^^
> >+       clock: clock-controller at 10030000 {
>    ^^^^^^^^
> >                 compatible = "samsung,exynos4210-clock";
>    ^^^^^^^^^^^^^^^^
> >                 reg =<0x10030000 0x20000>;
>    ^^^^^^^^^^^^^^^^
> >                 #clock-cells =<1>;
>    ^^^^^^^^^^^^^^^^
> 
> BTW, should be tab at the mark '^' not white space :(

Agreed, but this should be a separate patch.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
