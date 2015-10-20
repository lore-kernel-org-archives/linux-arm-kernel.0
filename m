From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 20 Oct 2015 12:29:12 +0200
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <56261778.8060400@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 10/20/2015 11:24 AM, Alim Akhtar wrote:
> Now we have a nice way to reboot/poweroff system using a generic
> syscon regmap based drivers, this series moves exynos SoCs to
> make use of the same.
> 

I tested this series on an Exynos5800 Peach Pi and an Exynos5422 Odroid XU.
Reboot and poweroff are working correctly on both boards with these patches.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
