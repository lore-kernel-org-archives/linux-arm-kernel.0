From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Aug 2013 03:07:44 +0900
Subject: [PATCH v3 07/22] ARM: dts: Remove '0x's from Exynos4210 DTSI file
In-Reply-To: <20130724150937.GO26801@laptop>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-7-git-send-email-lee.jones@linaro.org>
 <20130724150937.GO26801@laptop>
Message-ID: <51FFE9F0.1000100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/13 00:09, Lee Jones wrote:
> ... for the sake of consistency and assumed convention.
>
> Cc: Kukjin Kim<kgene.kim@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index b7f358a..53e2527 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -72,7 +72,7 @@
>                  };
    ^^^^^^^^^^^^^^^^
>          };
    ^^^^^^^^
>
> -       clock: clock-controller at 0x10030000 {
    ^^^^^^^^
> +       clock: clock-controller at 10030000 {
    ^^^^^^^^
>                  compatible = "samsung,exynos4210-clock";
    ^^^^^^^^^^^^^^^^
>                  reg =<0x10030000 0x20000>;
    ^^^^^^^^^^^^^^^^
>                  #clock-cells =<1>;
    ^^^^^^^^^^^^^^^^

BTW, should be tab at the mark '^' not white space :(

- Kukjin
