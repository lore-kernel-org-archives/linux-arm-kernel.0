From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 27 Apr 2016 17:30:50 -0400
Subject: [PATCH v2 3/3] ARM: dts: exynos: Lower SD card interface voltage
 to 2.8v on Odroid X/X2/U3
In-Reply-To: <1461765620-6833-3-git-send-email-k.kozlowski@samsung.com>
References: <1461765620-6833-1-git-send-email-k.kozlowski@samsung.com>
 <1461765620-6833-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <4691605f-545d-b721-af7d-e4b7669bcd79@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello 

On 04/27/2016 10:00 AM, Krzysztof Kozlowski wrote:
> Odroid X/X2/U3 schematics say that SD card vmmc regulator
> (LDO21/TFLASH) operates on 2.8 V. Mainline U-Boot uses that value as
> well. 2.8 V is common on Exynos-based boards. Additionally use some
> descriptive name for this regulator.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
