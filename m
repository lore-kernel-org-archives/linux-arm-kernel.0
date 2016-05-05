From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 5 May 2016 16:11:10 -0400
Subject: [RFC v2 12/13] ARM: dts: exynos: Switch the buck8 to GPIO mode on
 Odroid U3
In-Reply-To: <1462451666-17945-13-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-13-git-send-email-k.kozlowski@samsung.com>
Message-ID: <4e8db94a-982e-06a6-82a9-f102b964c7a8@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> Switch the control of buck8 to GPIO mode. It is faster than I2C/register
> mode and it is the easiest way to disable it (regulator state is a
> logical OR state of GPIO and register value).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
