From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 09:12:19 +0900
Subject: [RFT PATCH v2 6/6] ARM: dts: Mark eMMC as non-removable in
 exynos5250-snow-common
In-Reply-To: <1444927873-15140-7-git-send-email-javier@osg.samsung.com>
References: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
 <1444927873-15140-7-git-send-email-javier@osg.samsung.com>
Message-ID: <56243563.2050603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.10.2015 01:51, Javier Martinez Canillas wrote:
> The eMMC is non-removable so mark it using the non-removable DT
> property to avoid having to redetect it after a suspend/resume.
> 
> Also remove the card-detect-delay property that is not needed with
> non-removable.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Changes since v1:
> - None, new patch.
> 
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
