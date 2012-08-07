From: Dongjin.Kim@agreeyamobility.net (Dongjin Kim)
Date: Tue, 7 Aug 2012 19:57:33 +0000
Subject: =?ks_c_5601-1987?B?yLi9xTogW1BBVENIIDIvNF0gYXJtL2R0czogZXh5bm9zNDogQWRk?=
 =?ks_c_5601-1987?Q?_DTS_files_derived_from_common_Exynos4?=
In-Reply-To: <201208071938.26507.arnd@arndb.de>
References: <1344366398-19022-1-git-send-email-dongjin.kim@agreeyamobility.net>,
 <201208071938.26507.arnd@arndb.de>
Message-ID: <A6A3B7488C419F488E5B13FFD03C08AD2F4372EB@SN2PRD0510MB370.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I didn't use -M and I couldn't see any difference with the it.
Did I make something wrong on that patch?

Thank you in advance.
Dongjin.
________________________________________
?? ??: Arnd Bergmann [arnd at arndb.de]
?? ??: 2012? 8? 8? ??? ?? 4:38
?? ??: Dongjin Kim
??: Dongjin Kim; Russell King; Thomas Abraham; Kukjin Kim; Grant Likely; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
??: Re: [PATCH 2/4] arm/dts: exynos4: Add DTS files derived from common Exynos4

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
