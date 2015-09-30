From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Sep 2015 09:16:21 +0900
Subject: [PATCH v2] ARM: dts: exynos4412-trats2: remove
 regulator-compatible usage
In-Reply-To: <1443436714-4488-1-git-send-email-javier@osg.samsung.com>
References: <1443436714-4488-1-git-send-email-javier@osg.samsung.com>
Message-ID: <560B29D5.8050105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.09.2015 19:38, Javier Martinez Canillas wrote:
> The regulator-compatible property from the regulator DT binding was
> deprecated and the correct approach is to use the node's name.
> 
> This patch has no functional changes but by not using a deprecated
> property, new DTS based on this one will not carry the same issue.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Changes in v2:
> - Fixed typo on LDO10. Pointed out by Anand Moon.
> 
>  arch/arm/boot/dts/exynos4412-trats2.dts | 105 +++++++++++---------------------
>  1 file changed, 35 insertions(+), 70 deletions(-)
> 

Tested on Trats2 board:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
