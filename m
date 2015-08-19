From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 19 Aug 2015 17:44:02 +0900
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable DWC2 USB driver and USB
 ethernet gadget
In-Reply-To: <1439972377-22683-1-git-send-email-m.szyprowski@samsung.com>
References: <55D30313.7080107@osg.samsung.com>
 <1439972377-22683-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <55D441D2.4070506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.08.2015 17:19, Marek Szyprowski wrote:
> DWC2 (s3c-hsotg) hardware module is available on many Exynos based boards,
> so enable DWC2 driver as well as the most common USB Ethernet gadget.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> Changes since v1: build DWC2 and USB gadget as modules
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Thanks Marek for the patch.
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
