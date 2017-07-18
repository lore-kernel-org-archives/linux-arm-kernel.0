From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 07:15:13 +0200
Subject: [PATCH] arm64: dts: exynos: remove num-slots from exynos platforms
In-Reply-To: <1499159859-67028-1-git-send-email-shawn.lin@rock-chips.com>
References: <1499159859-67028-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20170718051513.GB22637@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 05:17:39PM +0800, Shawn Lin wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 --
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts       | 2 --
>  2 files changed, 4 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
