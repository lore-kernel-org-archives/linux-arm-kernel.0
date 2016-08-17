From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 17 Aug 2016 11:23:22 -0400
Subject: [PATCH] ARM: dts: exynos: Use stdout non-deprecated property and
 add serial options to Odroid XU/XU3/XU4
In-Reply-To: <1471419298-10414-1-git-send-email-k.kozlowski@samsung.com>
References: <1471419298-10414-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <aaa3911a-1f5d-3567-6992-a24ef7dc2023@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 08/17/2016 03:34 AM, Krzysztof Kozlowski wrote:
> The "linux,stdout-path" is deprecated.
> 
> Add serial options so the console can be properly configured when
> bootloader does not pass "console" parameter to command line.  Without
> options and lack of "console", the serial output dies during boot (just
> after probing sound).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
