From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 19 Jul 2016 10:49:43 -0400
Subject: [PATCH] ARM: exynos_defconfig: Enable PM_DEBUG
In-Reply-To: <1468926554-22204-1-git-send-email-k.kozlowski@samsung.com>
References: <1468926554-22204-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <0b91df86-02c7-a4ba-4aba-7d3ed0bf28e9@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 07/19/2016 07:09 AM, Krzysztof Kozlowski wrote:
> PM_DEBUG and PM_ADVANCED_DEBUG bring some information useful for
> development and they should not cause any significant overhead.  Enable
> them in default configuration so debugging would be slightly easier.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

I agree that it's good to have these enabled to make debugging easier.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
