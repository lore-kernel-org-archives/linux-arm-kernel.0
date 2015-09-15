From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 15 Sep 2015 09:02:52 +0900
Subject: [PATCH v2] ARM: exynos_defconfig: Enable USB Video Class support
In-Reply-To: <1442232259-777-1-git-send-email-javier@osg.samsung.com>
References: <1442232259-777-1-git-send-email-javier@osg.samsung.com>
Message-ID: <55F7602C.5060108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.09.2015 21:04, Javier Martinez Canillas wrote:
> The Exynos5420 Peach Pit and Exynos5800 Peach Pi boards have a built-in
> Silicon Motion USB UVC WebCam. Enable support for the USB Video Class
> driver and its needed media Kconfig symbols so the camera is supported.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Changes in v2:
> - Enable tristate Kconfig options as module instead of built-in.
>   Suggested by Krzysztof Kozlowski.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
