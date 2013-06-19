From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 19 Jun 2013 08:39:52 +0530
Subject: [GIT PULL 00/10] Samsung 2nd pull-request for v3.11
In-Reply-To: <51C0BC2D.80705@samsung.com>
References: <51C0BC2D.80705@samsung.com>
Message-ID: <CAK9yfHx--0dKDzdpBz3o_V_j+D+4f_N576rwuuVcJbMROtx=mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 19 June 2013 01:29, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd, Olof
>
> This is 2nd pull-request for Samsung stuff for v3.11.
>
> This is including following branches.
> v3.11-next/cleanup-samsung
> v3.11-next/exynos-arch-2
> v3.11-next/exynos-dt-2
> v3.11-next/s3c24xx-dt-2
> v3.11-next/dt-n-clk-audio
> v3.11-next/remove-nondt-exynos-3
> v3.11-next/s3c24xx-pinctrl-2
> v3.11-next/soc-exynos5420
> v3.11-next/samsung-defconfig
> v3.11-next/non-critical-fixes
>
> Just note, for remove-nondt-exynos-3 branch, small merge conflict will be
> happened. I added my resolution in the pull-request.
>
> If any problems, please kindly let me know.
>
> Thanks,
> - Kukjin

[snip]
>
> Sachin Kamat (3):
>       ARM: dts: Add PWM related pinctrl entries for exynos4210
>       ARM: dts: Add LCD related pinctrl entries for exynos4210
>       ARM: dts: Add FIMD node to Origen4210 board

I dont see my following patch in this pull request which you said you
had applied.
https://patchwork.kernel.org/patch/2469891/


-- 
With warm regards,
Sachin
