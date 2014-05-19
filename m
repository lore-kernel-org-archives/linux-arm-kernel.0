From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 May 2014 00:56:19 +0900
Subject: [PATCH V2 0/2] ARM: dts: snow: add backlight node
In-Reply-To: <1400476540-14828-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1400476540-14828-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <537A29A3.4000302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/14 14:15, Ajay Kumar wrote:
> This series is based on Kukjin Kim's tree, for-next branch.
>
> This series adds:
> 	-- pinctrl definitions for pwmX_out on exynos5250
> 	-- pwm-backlight DT node for exynos5250 based snow board
>
> Changes since V1:
> 	-- Added the branch name against which patches are created.
> 	-- Rebase the patches on top of for-next branch.
>
> Ajay Kumar (2):
>    [PATCH V2 1/2] ARM: dts: Add pwmX_out pinctrl nodes to Exynos5250
>    [PATCH V2 2/2] ARM: dts: enable pwm backlight for snow
>
>   arch/arm/boot/dts/exynos5250-pinctrl.dtsi |   28 ++++++++++++++++++++++++++++
>   arch/arm/boot/dts/exynos5250-snow.dts     |   10 ++++++++++
>   2 files changed, 38 insertions(+)
>
As I requested before, it looks good to me, applied.

Thanks,
Kukjin
