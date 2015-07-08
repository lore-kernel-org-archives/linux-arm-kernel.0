From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jul 2015 17:29:26 +0900
Subject: [PATCH 2/4] ARM: dts: Extend exynos5250-pinctrl nodes using labels
 instead of paths
In-Reply-To: <1436333790-18219-3-git-send-email-javier@osg.samsung.com>
References: <1436333790-18219-1-git-send-email-javier@osg.samsung.com>
 <1436333790-18219-3-git-send-email-javier@osg.samsung.com>
Message-ID: <559CDF66.6080609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.07.2015 14:36, Javier Martinez Canillas wrote:
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
> ---
> 
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi | 1600 ++++++++++++++---------------
>  1 file changed, 799 insertions(+), 801 deletions(-)
> 

I didn't look carefully enough to call it a review (I trust the 'diff'
of yours) but it seems fine to me:

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
