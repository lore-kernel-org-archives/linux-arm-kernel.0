From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 14:28:45 +0900
Subject: [PATCH v2 04/11] ARM: EXYNOS: add interrupt definitions for
 EXYNOS5250
In-Reply-To: <1328981685-8602-5-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-5-git-send-email-kgene.kim@samsung.com>
Message-ID: <054801ccec6b$da57ba60$8f072f20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
>
> This patch adds the interrupt definitions for EXYNOS5250 at
> <mach/irqs.h> file. Basically, now it is needed for EXYNOS5250
> interrupt and will be updated for single zImage next time.

[...]

> +#define JOP_IRQ_NUMBER		IRQ_SPI(118)

Typo :( Should be 'JOB_IRQ_...'

And I need to update every IRQ definitions...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
