From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 09 Jul 2015 08:58:32 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: Remove old Samsung USB PHY
 configs
In-Reply-To: <1436395246-17540-1-git-send-email-javier@osg.samsung.com>
References: <1436395246-17540-1-git-send-email-javier@osg.samsung.com>
Message-ID: <559DB928.1000202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.07.2015 07:40, Javier Martinez Canillas wrote:
> The old drivers/usb/phy/phy-samsung-usb{2,3} are now deleted since
> were replaced by newers drivers that use the Generic PHY framework
s/newers/newer/
(this can be fixed when applying)

> but their Kconfig options were left over in multi_v7_defconfig.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
