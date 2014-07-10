From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Jul 2014 20:34:20 +0200
Subject: [PATCH v4 0/7] ARM: at91: move aic driver to drivers/irqchips
In-Reply-To: <1405012462-766-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1405012462-766-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140710203420.64ab24df@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jul 2014 19:14:15 +0200
Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This series moves the AIC driver to the irqchip directory and make use of
> the generic chip framework whenever possible.
> 
> This driver only support DT boards (all legacy board files should be soon
> replaced by their DT versions).
> 
> Since the last version AIC and AIC5 code have been split and common
> functions have been moved to irq-atmel-aic-common.c.
> I know there is not much code in this file and it could have been
> duplicated in AIC and AIC5 drivers, but I'm planning to add more common
> stuff soon (AIC irq fixups previously done in
> arch/arm/mach-at91/sysirq_mask.c).

This is what I was talking about:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/271425.html

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
