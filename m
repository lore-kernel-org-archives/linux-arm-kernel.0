From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 May 2015 12:38:12 +0900
Subject: [RFC PATCH 3/4] ARM: dts: Add SPI flash node to exynos5250-snow
In-Reply-To: <1432042454-19234-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <555C01A4.1010707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.05.2015 22:34, Javier Martinez Canillas wrote:
> From: Doug Anderson <dianders@chromium.org>
> 
> Exynos5250 Snow machine has a SPI flash memory that is used to
> store firmware and different system parameters and data.
> 
> Add information about the SPI flash chip so that user-space tools
> can access it.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Olof Johansson <olofj@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5250-snow.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
