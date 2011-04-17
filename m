From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Apr 2011 06:52:35 +0900
Subject: samsung: Convert irq-vic-timer to generic irq chip
In-Reply-To: <20110416211307.781114571@linutronix.de>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.781114571@linutronix.de>
Message-ID: <008a01cbfd49$c6ead5f0$54c081d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>  arch/arm/mach-s3c64xx/irq.c                        |    7 --
>  arch/arm/plat-s5p/irq.c                            |    6 -
>  arch/arm/plat-samsung/include/plat/irq-vic-timer.h |    2
>  arch/arm/plat-samsung/irq-vic-timer.c              |   73
++++++++----------
> ---
>  4 files changed, 31 insertions(+), 57 deletions(-)
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
