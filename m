From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 2 Sep 2015 10:01:42 +0200
Subject: [PATCH v2 2/2] ARM: dts: Add exynos5422-odroidxu4 board
In-Reply-To: <1441157405-22123-2-git-send-email-k.kozlowski@samsung.com>
References: <1441157405-22123-1-git-send-email-k.kozlowski@samsung.com>
 <1441157405-22123-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <55E6ACE6.3030709@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/02/2015 03:30 AM, Krzysztof Kozlowski wrote:
> Add Hardkernel Odroid XU4 board Device Tree sources. The board differs
> from Odroid XU3 and XU3-Lite by:
> 1. No green and red leds (except standard red power led).
> 2. No audio codec.
> 3. Two USB3 ports in host mode (no micro USB3 connector for OTG).
> 4. Realtek RTL8153-CG gigabit network adapter (instead of SMSC9514).
> 5. Additional connector with IO ports (I2S_0, I2C_5).
> 6. No DisplayPort (like XU3-Lite).
> 7. No TI INA231 power measurement sensors (like XU3-Lite).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
