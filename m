From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 20:33:07 +0000
Subject: [PATCH 3/7 v2] Introduce plat-tcc irq framework
In-Reply-To: <20100325201057.GF2047@bluebox.local>
References: <20100325200427.GC2047@bluebox.local>
	<20100325201057.GF2047@bluebox.local>
Message-ID: <20100325203307.GD24984@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 09:10:58PM +0100, Hans J. Koch wrote:
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/ptrace.h>
> +
> +#include <asm/irq.h>
> +#include <asm/mach/irq.h>
> +#include <asm/io.h>

linux/io.h
