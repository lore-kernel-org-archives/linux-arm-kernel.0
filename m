From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 May 2015 12:37:29 +0900
Subject: [RFC PATCH 2/4] ARM: dts: Add SPI flash node for Peach boards
In-Reply-To: <1432042454-19234-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <555C0179.8040102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.05.2015 22:34, Javier Martinez Canillas wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> Peach Pit and Pi machines have a SPI flash memory that is used to
> store firmware and different system parameters and data.
> 
> Add information about the SPI flash chip so that user-space tools
> can access it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I assume this can go through samsung-soc tree (after documenting new
compatible)?

The exynos5800-peach-pi.dts and exynos5420-peach-pit.dts have a lot of
common nodes. I wonder if there is a common part which could have its
own dtsi? Like exynos4412-odroid-common.dtsi?

Best regards,
Krzysztof
