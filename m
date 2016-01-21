From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Jan 2016 10:58:32 +0900
Subject: [PATCH 8/8] ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig
 symbol
In-Reply-To: <1453310088-29985-9-git-send-email-javier@osg.samsung.com>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <1453310088-29985-9-git-send-email-javier@osg.samsung.com>
Message-ID: <56A03B48.7080507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.01.2016 02:14, Javier Martinez Canillas wrote:
> The driver has been removed so the Kconfig symbol is not valid anymore.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> 
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
