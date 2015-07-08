From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jul 2015 17:30:50 +0900
Subject: [PATCH 4/4] ARM: dts: Extend exynos5420-pinctrl nodes using labels
 instead of paths
In-Reply-To: <1436334389-18779-1-git-send-email-javier@osg.samsung.com>
References: <1436334389-18779-1-git-send-email-javier@osg.samsung.com>
Message-ID: <559CDFBA.40103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.07.2015 14:46, Javier Martinez Canillas wrote:
> A previously defined Device Tree node, can be extended either by defining
> a node using the same full path or by creating a label for the node and
> referencing to it.
> 
> Using full paths is more error prone since if there was a typo error, a
> new node will be created instead of extending the node as it was desired.
> This will lead to run-time errors that could be hard to detect.
> 
> A misstyped label on the other hand, will cause a dtc compile error which

s/misstyped/mistyped/

> makes it easier to detect the mistake since happens at build-time instead.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi | 1411 ++++++++++++++---------------
>  1 file changed, 705 insertions(+), 706 deletions(-)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
