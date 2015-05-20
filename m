From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 May 2015 12:38:38 +0900
Subject: [RFC PATCH 4/4] ARM: exynos_defconfig: Enable user mode SPI device
 support
In-Reply-To: <1432042454-19234-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <555C01BE.9080403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.05.2015 22:34, Javier Martinez Canillas wrote:
> Some Exynos boards have SPI devices such as flash memories
> that need to be accessed from user-space.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
