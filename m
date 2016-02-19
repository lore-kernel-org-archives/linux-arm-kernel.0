From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 19 Feb 2016 09:26:48 +0900
Subject: [PATCH 1/3] thermal: exynos: List vtmu-supply as optional property
 in DT binding
In-Reply-To: <1455819551-4666-2-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-2-git-send-email-javier@osg.samsung.com>
Message-ID: <56C66148.5060006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.02.2016 03:19, Javier Martinez Canillas wrote:
> The Exynos Thermal Management Unit binding says that the vtmu-supply
> is optional but is listed in the required properties section. Add an
> optional properties section and move the regulator property there.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
