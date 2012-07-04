From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Jul 2012 00:24:54 -0700
Subject: [RESEND PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate
 class
In-Reply-To: <1341320447-18918-2-git-send-email-hvaibhav@ti.com>
References: <1341320447-18918-1-git-send-email-hvaibhav@ti.com>
 <1341320447-18918-2-git-send-email-hvaibhav@ti.com>
Message-ID: <20120704072454.GO1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120703 06:12]:
> Initially, we decided to make am33xx family of device to fall
> under omap3 class (cpu_is_omap34xx() = true), since it carries
> Cortex-A8 core. But while adding complete baseport support
> (like, clock, power and hwmod) support, it is observed that,
> we are creating more and more problems by treating am33xx device
> as omap3 family, as nothing matches between them
> (except cortex-A8 mpu).
> 
> So,  after long discussion we have came to the conclusion that,
> we should not consider am33xx device as omap3 family, instead
> create separate class (SOC_AM33XX) under OMAP2PLUS.
> This means, for am33xx device, cpu_is_omap34xx() will return false,
> and only cpu_is_am33xx() will be true.

Thanks applying both.

Regards,

Tony
