From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 Jan 2017 13:24:43 -0300
Subject: [PATCH v1.1] ARM: multi_v7_defconfig: Enable power sequence for
 Odroid U3
In-Reply-To: <20170107091651.10560-1-krzk@kernel.org>
References: <20170107085203.4431-5-krzk@kernel.org>
 <20170107091651.10560-1-krzk@kernel.org>
Message-ID: <d8ee24b1-9d6b-e76f-b5ef-71706efbf9e5@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

I think it would had been clearer if the subject prefix was "[PATCH v1.1 4/4]" :)

On 01/07/2017 06:16 AM, Krzysztof Kozlowski wrote:
> Odroid U3 needs a power sequence for lan9730, if it was enabled by
> bootloader.  Also enable the USB3503 HSCI to USB2.0 driver (device
> is present on Odroid U3).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 

Do you think that makes sense to also enable GPIO_SYS for debugging
purposes as you do in patch 3/4?

In any case the patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
