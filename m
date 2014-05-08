From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 08 May 2014 14:39:42 +0900
Subject: [PATCH 0/5] ARM: dts: enable display for peach-pit and snow boards
In-Reply-To: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
References: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <001e01cf6a7f$e9965c90$bcc315b0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, April 20, 2014 8:49 PM, Rahul Sharma wrote:
> 
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Add nodes for fimd and dp controller for exynos5250 based snow
> and exynos5420 based peach-pit board.
> 
> This series is based on Kukjin Kims, for-next branch.
> 
> It is dependent on
> 1) Andrew Bresticker's patch for hpd gpio addition, avilable at
> http://www.spinics.net/lists/linux-samsung-soc/msg28827.html
> 2) Arun's patch for adding peach-pit board dts file at
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg28846.html.

One more thing. These patches were based against the following patches.

3) Rahul Sharma's patch for hdmi support for exynos5 based dt files.
([PATCH 0/7] ARM: dts: enable hdmi for exynos5 based peach and snow boards)
http://www.spinics.net/lists/linux-samsung-soc/msg29011.html

Please check the dependency.
Anyone does not want to waste the time, due to patch breakage.

Best regards,
Jingoo Han

> 
> Rahul Sharma (5):
>   ARM: dts: move dp hpd line to the board file for exynos5420
>   ARM: dts: enable fimd for exynos5250 based snow board
>   ARM: dts: enable dp-controller for exynos5250 based snow board
>   ARM: dts: enable fimd for exynos5420 based peach-pit board
>   ARM: dts: enable dp-controller for exynos5420 based peach-pit board
> 
>  arch/arm/boot/dts/exynos5250-snow.dts      |   32 +++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   39 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 -----
>  arch/arm/boot/dts/exynos5420-smdk5420.dts  |    7 +++++
>  4 files changed, 78 insertions(+), 7 deletions(-)
> 
> --
> 1.7.9.5
