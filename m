From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Aug 2012 19:38:26 +0000
Subject: [PATCH 2/4] arm/dts: exynos4: Add DTS files derived from common
 Exynos4
In-Reply-To: <1344366398-19022-1-git-send-email-dongjin.kim@agreeyamobility.net>
References: <1344366398-19022-1-git-send-email-dongjin.kim@agreeyamobility.net>
Message-ID: <201208071938.26507.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 August 2012, Dongjin Kim wrote:
> 
> This patch creates a DTS file, exynos4.dtsi, for Exynos4210/4x12 and it
> describes common device nodes. SoC specific device nodes are described in
> another DTS file derived from this, exynos4210.dtsi and exynos4412.dtsi.
> 
> exynos4412.dtsi is added new for Exynos4412 as well as exynos4210 is modified
> for Exynos4210 specific device nodes.
> 
> Signed-off-by: Dongjin Kim <dongjin.kim@agreeyamobility.net>
> ---
>  arch/arm/boot/dts/exynos4.dtsi    |  404 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4210.dtsi |  374 +---------------------------------
>  arch/arm/boot/dts/exynos4412.dtsi |  104 ++++++++++
>  3 files changed, 510 insertions(+), 372 deletions(-)

Looks good in principle. I would hope that "git format-patch -M" can detect this
mostly-moved filed. Did you use that?

	Arnd
