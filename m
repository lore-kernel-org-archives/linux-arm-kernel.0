From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 20 May 2012 01:05:05 +0900
Subject: [PATCH] ARM: S3C24XX: add support for second irq set of S3C2416
In-Reply-To: <201203032219.45813.heiko@sntech.de>
References: <201203032219.45813.heiko@sntech.de>
Message-ID: <4FB7C4B1.7050805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/12 06:19, Heiko St?bner wrote:
> The S3C2416 has a separate second interrupt register-set to support
> additional irqs. This patch adds the necessary constants and registers
> the irq handlers for it.
>
> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
> ---
> Patch should go on top of the current s3c24xx consolidation
>
>   arch/arm/mach-s3c24xx/include/mach/irqs.h    |   15 ++++-
>   arch/arm/mach-s3c24xx/irq-s3c2416.c          |   98 ++++++++++++++++++++++++++
>   arch/arm/mach-s3c24xx/s3c2416.c              |    1 +
>   arch/arm/plat-samsung/include/plat/s3c2416.h |    3 +
>   4 files changed, 116 insertions(+), 1 deletions(-)
>
Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
