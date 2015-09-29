From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 29 Sep 2015 16:21:07 +0900
Subject: [PATCH RESEND] ARM: dts: Move display-timings node from fimd to dp
In-Reply-To: <1442494120-463-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494120-463-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <560A3BE3.3090504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 17.09.2015 o 21:48, Tomeu Vizoso pisze:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch moves the display-timings node from fimd to dp to reflect the
> device tree bindings change.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> [tomeu.vizoso at collabora.com: Rebased]
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> ---
> 
> Hi,
> 
> looks like a long time ago the bindings were changed and the DTs for
> these boards weren't updated.
> 
> I have retaken Sean's forgotten patch and rebased it, but I have only
> tested on an Arndale that exynos-drm doesn't complain about missing
> timings.
> 
> Regards,
> 
> Tomeu
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts  |  8 ++++----
>  arch/arm/boot/dts/exynos5250-smdk5250.dts | 16 ++++++++--------
>  arch/arm/boot/dts/exynos5420-smdk5420.dts |  7 ++++---
>  3 files changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
