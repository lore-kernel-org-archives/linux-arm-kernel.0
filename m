From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 31 Mar 2016 13:46:26 +0900
Subject: [PATCH v4 6/9] ARM: dts: Add initial gpio setting of MMC2 device
 for exynos3250-monk
In-Reply-To: <1459392485-11327-7-git-send-email-cw00.choi@samsung.com>
References: <1459392485-11327-1-git-send-email-cw00.choi@samsung.com>
 <1459392485-11327-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <56FCABA2.6030708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.03.2016 11:48, Chanwoo Choi wrote:
> This patch adds initial pin configuration of MMC2 device on exynos3250-monk
> board because the MMC2 gpio pin (gpk2[0-6]) are NC (not connected) state.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-monk.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Thanks, applied this one for v4.7 with adjusted title.

I'll wait with other patches for Sylwester's branch/tag.

Best regards,
Krzysztof
