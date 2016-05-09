From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 12:44:50 -0400
Subject: [PATCH] ARM: dts: exynos: Only Odroid XU3-family boards use DTSI
 with CPU thermal nodes
In-Reply-To: <1462774789-15360-1-git-send-email-k.kozlowski@samsung.com>
References: <1462774789-15360-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <d7e37f87-c794-f0ad-73d1-8e976c37471b@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/09/2016 02:19 AM, Krzysztof Kozlowski wrote:
> Include the CPU thermal nodes directly in Odroid XU3-family common DTS
> because it is the only user of it. Keeping it in separate DTSI node does
> not bring benefits because:
> 1. It is not re-usable on other non-fan boards (fan is referenced),
> 2. It won't be re-used on future Odroid XU board because different
>    CPU cluster behavior.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Agreed with both points and the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
