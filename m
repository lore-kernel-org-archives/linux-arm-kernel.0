From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 01 Nov 2013 18:09:18 +0100
Subject: [PATCH v2 4/4] ARM: dts: Add initial device tree support for
 EXYNOS5410
In-Reply-To: <1381763305-7085-5-git-send-email-v.tyrtov@samsung.com>
References: <1381763305-7085-1-git-send-email-v.tyrtov@samsung.com>
 <1381763305-7085-5-git-send-email-v.tyrtov@samsung.com>
Message-ID: <3553642.XBQjgGGvxT@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 of October 2013 19:08:25 Vyacheslav Tyrtov wrote:
> From: Tarek Dakhran <t.dakhran@samsung.com>
> 
> Add initial device tree nodes for EXYNOS5410 SoC and SMDK5410 board.
> 
> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/exynos5410-smdk5410.dts |  65 ++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi         | 209
> ++++++++++++++++++++++++++++++ 3 files changed, 275 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
>  create mode 100644 arch/arm/boot/dts/exynos5410.dtsi

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
