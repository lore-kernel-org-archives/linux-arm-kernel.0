From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 13:58:06 +0200
Subject: [PATCH] ARM: dts: exynos: Remove "simple-bus" compatible from
 fimc-is node
In-Reply-To: <1474014825-28969-1-git-send-email-s.nawrocki@samsung.com>
References: <CGME20160916083407eucas1p103af8b14d09de02ea25715c495b9f8fc@eucas1p1.samsung.com>
 <1474014825-28969-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <6ea5a94f-fc21-d5d4-faf3-bbee9cc8160c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2016 10:33 AM, Sylwester Nawrocki wrote:
> The "simple-bus" compatible was originally added for fimc-is only
> to ensure the child devices instantiation.  The child devices are
> now being created by the parent device driver so remove the
> "simple-bus" compatible.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof
