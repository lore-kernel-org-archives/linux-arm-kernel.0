From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 13 Jul 2015 16:48:37 +0900
Subject: [PATCH 1/3] mfd: max77686: Don't suggest in binding to use a
 deprecated property
In-Reply-To: <1436773348-15316-2-git-send-email-javier@osg.samsung.com>
References: <1436773348-15316-1-git-send-email-javier@osg.samsung.com>
 <1436773348-15316-2-git-send-email-javier@osg.samsung.com>
Message-ID: <55A36D55.4070400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.07.2015 16:42, Javier Martinez Canillas wrote:
> The regulator-compatible property from the regulator DT binding was
> deprecated. But the max77686 DT binding doc still suggest to use it
> instead of the regulator node name's which is the correct approach.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  Documentation/devicetree/bindings/mfd/max77686.txt | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
