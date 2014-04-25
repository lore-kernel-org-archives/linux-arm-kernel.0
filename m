From: arunkk.samsung@gmail.com (Arun Kumar K)
Date: Fri, 25 Apr 2014 15:15:57 +0530
Subject: [PATCH 0/5] ARM: dts: enable display for peach-pit and snow boards
In-Reply-To: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
References: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CALt3h78pPMMDaQ495U6SCN8xwY8Wt6AD6tnie9CYdg2DMGPhEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Tested this whole series on peach-pit board.

Tested-by : Arun Kumar K <arun.kk@samsung.com>

On Sun, Apr 20, 2014 at 5:18 PM, Rahul Sharma <rahul.sharma@samsung.com> wrote:
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
