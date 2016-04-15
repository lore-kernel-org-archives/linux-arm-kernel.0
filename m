From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 15 Apr 2016 11:07:27 +0200
Subject: [PATCH v2 8/8] ARM: dts: Add support of Bus frequency using
 VDD_INT for exynos5422-odroidxu3
In-Reply-To: <1460701975-24178-9-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
 <1460701975-24178-9-git-send-email-cw00.choi@samsung.com>
Message-ID: <5710AF4F.9030300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 08:32 AM, Chanwoo Choi wrote:
> This patch adds the bus device tree nodes for INT (Internal) block
> to enable the AMBA bus frequency scaling and add the NoC (Network on Chip)
> Probe Device Tree node to measure the bandwidht for AMBA AXI bus.
> 
> The WCORE bus bus is parent device in INT block using VDD_INT.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
