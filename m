From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 Jan 2017 13:19:28 -0300
Subject: [PATCH 3/4] ARM: exynos_defconfig: Enable power sequence for
 Odroid U3
In-Reply-To: <20170107085203.4431-4-krzk@kernel.org>
References: <20170107085203.4431-1-krzk@kernel.org>
 <20170107085203.4431-4-krzk@kernel.org>
Message-ID: <1aae570c-6a63-9893-70fc-2313a57f664a@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/07/2017 05:52 AM, Krzysztof Kozlowski wrote:
> Odroid U3 needs a power sequence for lan9730, if it was enabled by
> bootloader.  Enable also GPIO_SYSFS which is useful for playing with
> GPIO during debug process.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
