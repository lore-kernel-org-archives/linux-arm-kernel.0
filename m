From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 14 Dec 2013 14:11:12 -0500
Subject: [PATCH 0/2] gpio: davinci: reuse for keystone arch
In-Reply-To: <1386871973-26762-1-git-send-email-grygorii.strashko@ti.com>
References: <1386871973-26762-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <52ACAD50.6060003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus, Sekhar,

On Thursday 12 December 2013 01:12 PM, Grygorii Strashko wrote:
> This series is intended to update Davinci GPIO driver and reuse
> it for Keystone SoCs, because Keystone uses the similar GPIO IP like Davinci.
> Keystone GPIO IP: supports:
> - up to 32 GPIO lines;
> - only unbanked irqs;
> 
> See Documentation:
> Keystone - http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
> 
> This series depends on:
> [1] "[PATCH 1/2] gpio: davinci: Fix a check for unbanked gpio"
> https://lkml.org/lkml/2013/11/8/22
> [2] "[PATCH v6 0/6] gpio: daVinci: cleanup and feature enhancement"
> https://www.mail-archive.com/devicetree at vger.kernel.org/msg05970.html
> [3] "gpio: davinci: get rid of DAVINCI_N_GPIO"
> https://lkml.org/lkml/2013/11/26/405
> [4] "gpio: introduce GPIO_DAVINCI kconfig option"
> https://lkml.org/lkml/2013/11/26/435
> [5] "gpio: davinci: use chained_irq_enter/chained_irq_exit API"
> https://lkml.org/lkml/2013/11/26/428
> 
> To handle all dependencies, I've created a branch where I collected all 
> "ready to merge" patches (all acks added in patches) and this series:
> - https://github.com/grygoriyS/linux.git
> - branch: keystone-master-gpio-for-next
> 
Can one of you pull all these patches ?

If needed I can take these patches to arm-soc with Linus's ack
or can prepare a pull request which Linus W can pull from from.

Regards,
Santosh
