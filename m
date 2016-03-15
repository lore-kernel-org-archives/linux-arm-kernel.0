From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 15 Mar 2016 11:38:42 +0900
Subject: [PATCH v2 7/7] ARM: dts: Add initial gpio setting of MMC2 device
 for exynos3250-monk
In-Reply-To: <1458007695-3627-8-git-send-email-cw00.choi@samsung.com>
References: <1458007695-3627-1-git-send-email-cw00.choi@samsung.com>
 <1458007695-3627-8-git-send-email-cw00.choi@samsung.com>
Message-ID: <56E775B2.9010100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.03.2016 11:08, Chanwoo Choi wrote:
> This patch adds initial pin configuration of MMC2 device on exynos3250-monk
> board because the MMC2 gpio pin (gpk2[0-6]) are NC (not connected) state.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-monk.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>

The patch should go in before setting these pins to MMC2 (so before
patch 4/7) so there won't be any change in behaviour.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>



Best regards,

Krzysztof
