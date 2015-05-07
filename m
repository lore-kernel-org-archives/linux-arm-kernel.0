From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 07 May 2015 11:16:58 +0200
Subject: [RFT PATCH v2 0/3] drm/exynos: Fix build breakage on
 !DRM_EXYNOS_FIMD
In-Reply-To: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
References: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <554B2D8A.6070209@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/07/2015 02:04 AM, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
> Hi,
> 
> This is second try to fix the build breakage introduced in 1c363c7cccf6
> ("drm/exynos: Enable DP clock to fix display on Exynos5250 and other").
> 
> The fix is not trivial so I am kindly asking for testing on Chromebook
> and other DP-enabled boards (I don't have Chromebook right now).
> 

For all the series:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

> Tested on Exynos4412 Trats2 board.
> 

On Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi Chromebooks:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

> Best regards,
> Krzysztof
> 

Best regards,
Javier
