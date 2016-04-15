From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 15 Apr 2016 11:04:52 +0200
Subject: [PATCH v2 4/8] ARM: dts: Add NoC Probe dt node for Exynos542x SoC
In-Reply-To: <1460701975-24178-5-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
 <1460701975-24178-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <5710AEB4.3050008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 08:32 AM, Chanwoo Choi wrote:
> This patch adds the NoCP (Network on Chip Probe) Device Tree node
> to measure the bandwidth of memory and g3d in Exynos542x SoC.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
