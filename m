From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Jun 2015 13:50:30 +0900
Subject: [RFT v2 10/48] irqchip: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
In-Reply-To: <1433391238-19471-11-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-11-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <556FD916.3070103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.06.2015 13:13, Jiang Liu wrote:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/irqchip/exynos-combiner.c   |    4 ++--

For exynos:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
