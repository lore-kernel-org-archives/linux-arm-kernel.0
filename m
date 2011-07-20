From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Jul 2011 00:40:40 +0900
Subject: [PATCH v3 0/6] ARM: EXYNOS4: NURI Board Configuration Update
In-Reply-To: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <06c001cc46f3$6440fe40$2cc2fac0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> 1/6: Increase NR_IRQS for MAX8997
> 2/6: Add MAX8997 PMIC
> 3/6: Add MAX17042 Fuel Gauge
> 4/6: Add ADC
> 5/6: Add MAX8903 Secondary Charger
> 6/6: Add RTC-S3C
> 
> ps. Tushar, I didn't seperated MAX8997 support code out of mach-nuri.c,
yet
> because I still have no idea about how similar the Origen board is with
NURI board.
> 
> MyungJoo Ham (6):
>   ARM: EXYNOS4: Increase NR_IRQS for devices with more IRQs
>   Exynos4 NURI: configure regulators and PMIC (MAX8997)
>   Exynos4 NURI: configure MAX17042 fuel gauge
>   Exynos4 NURI: configure ADC.
>   Exynos4 NURI: configure MAX8903 secondary charger
>   Exynos4 NURI: configure rtc-s3c.
> 
>  arch/arm/mach-exynos4/include/mach/irqs.h |    2 +-
>  arch/arm/mach-exynos4/mach-nuri.c         |  739
> ++++++++++++++++++++++++++++-
>  2 files changed, 739 insertions(+), 2 deletions(-)
> 
> --
> 1.7.4.1

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
