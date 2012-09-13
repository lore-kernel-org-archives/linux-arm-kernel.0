From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Sep 2012 10:25:19 +0200
Subject: [PATCH 2/5] ARM: Add interface for registering and calling
 firmware-specific operations
In-Reply-To: <1347524018-19301-3-git-send-email-t.figa@samsung.com>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <1347524018-19301-3-git-send-email-t.figa@samsung.com>
Message-ID: <7531144.4Y7oHlfebV@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 of September 2012 10:13:35 Tomasz Figa wrote:
> In code using firmware ops:
> 
> 	__raw_writel(virt_to_phys(exynos4_secondary_startup),
> 		CPU1_BOOT_REG);
> 
> 	/* Call Exynos specific smc call */
> 	do_firmware_op(cpu_boot, cpu);

Typo, s/do_/call_/ .

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
