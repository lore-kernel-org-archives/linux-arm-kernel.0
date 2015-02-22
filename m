From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Sun, 22 Feb 2015 19:00:02 +0100
Subject: [PATCH v5 05/18] ARM: dts: exynos5420: add sysmmu nodes
In-Reply-To: <1422028288-891-6-git-send-email-m.szyprowski@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
 <1422028288-891-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <54EA1922.2030000@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.01.2015 um 16:51 schrieb Marek Szyprowski:
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 181 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 181 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 1b62410..b8f1c9f 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
[...]
> @@ -925,4 +932,178 @@
>  		samsung,sysreg-phandle = <&sysreg_system_controller>;
>  		samsung,pmureg-phandle = <&pmu_system_controller>;
>  	};
> +
> +	sysmmu_g2dr: sysmmu at 0x10A60000 {
[snip]

Unit addresses are without 0x. Please also check the sort order.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
