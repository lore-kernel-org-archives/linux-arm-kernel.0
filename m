From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 29 Jun 2015 09:35:49 +0100
Subject: [PATCH] ARM: versatile: enable RTC DS1338 driver in defconfig
In-Reply-To: <1435552714-536-1-git-send-email-milo.kim@ti.com>
References: <1435552714-536-1-git-send-email-milo.kim@ti.com>
Message-ID: <55910365.3010105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+RMK

On 29/06/15 05:38, Milo Kim wrote:
> Versatile platform boards[*] support external RTC device, DS1338.
> It is compatible with rtc-ds1307 device driver.
> This driver requires not only RTC subsystem configuration but also I2C host
> bus support.
>
> QEMU[**] also supports this device by default.
>
> [*]  arch/arm/mach-versatile/core.c
> [**] hw/arm/versatilepb.c
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>


Not sure why you have cc-ed Vexpress maintainers for versatile platform
updates ? Did get_maintainer.pl gave these email address ? Please cc RMK
in future.

Regards,
Sudeep
