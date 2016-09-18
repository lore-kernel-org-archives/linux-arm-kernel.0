From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sun, 18 Sep 2016 11:20:43 -0400
Subject: [PATCH 4/7] ARM: dts: exynos: Use human-friendly symbols for
 interrupt properties in exynos5
In-Reply-To: <1474062122-22720-5-git-send-email-krzk@kernel.org>
References: <1474062122-22720-1-git-send-email-krzk@kernel.org>
 <1474062122-22720-5-git-send-email-krzk@kernel.org>
Message-ID: <f16ace70-f391-39fb-c8ee-ffbacb52f1ea@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/16/2016 05:41 PM, Krzysztof Kozlowski wrote:
> Replace hard-coded values of type of GIC interrupt and its flags with
> respective macros from header to increase code readability
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

On an Exynos5800 Peach Pi Chromebook and an Exynos5422 Odroid XU4 board:

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
