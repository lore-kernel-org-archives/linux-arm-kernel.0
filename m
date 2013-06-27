From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jun 2013 09:43:58 +0100
Subject: [PATCH] ARM: shmobile: r8a7790 SMP prototype v2
In-Reply-To: <20130626235837.11576.86389.sendpatchset@w520>
References: <20130626235837.11576.86389.sendpatchset@w520>
Message-ID: <20130627084358.GA4283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 08:58:37AM +0900, Magnus Damm wrote:
> +#include <linux/smp.h>
> +#include <linux/irqchip/arm-gic.h>
> +#include <asm/cacheflush.h>
> +#include <asm/io.h>

Please always use linux/io.h
