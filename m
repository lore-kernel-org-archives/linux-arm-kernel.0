From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 5 Jul 2016 10:01:27 -0400
Subject: [PATCH] arm64: defconfig: Enable s2mps11 regulator clk and s3c
 rtc driver
In-Reply-To: <1467713211-16014-1-git-send-email-alim.akhtar@samsung.com>
References: <1467713211-16014-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <20dda870-4196-6160-59cf-ea6f9a5016c8@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 07/05/2016 06:06 AM, Alim Akhtar wrote:
> The s3c rtc controller on exynos7 platform uses rtc source clock
> from s2mps11 pmic. This patch enables the required bits to make
> rtc work on exynos7-espresso board.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
