From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 31 Mar 2016 13:46:04 +0900
Subject: [PATCH v4 1/9] ARM: dts: Add initial pin configuration for
 exynos3250-rinato
In-Reply-To: <1459392485-11327-2-git-send-email-cw00.choi@samsung.com>
References: <1459392485-11327-1-git-send-email-cw00.choi@samsung.com>
 <1459392485-11327-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <56FCAB8C.4070505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.03.2016 11:47, Chanwoo Choi wrote:
> This patch adds initial pin configuration using pinctrl subsystem
> to reduce leakage power-consumption of gpio pins in normal state.
> All pins included in this patch are NC (not connected) pin.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 38 +++++++++++++++++
>  arch/arm/boot/dts/exynos3250-rinato.dts   | 71 ++++++++++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 2 deletions(-)

Thanks, applied this one for v4.7 with adjusted title.

Best regards,
Krzysztof
