From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Dec 2011 15:17:23 +0000
Subject: [PATCH 1/6] irqdomain: export irq_domain_simple_ops for !CONFIG_OF
In-Reply-To: <1323058550-13368-3-git-send-email-shawn.guo@linaro.org>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
 <1323058550-13368-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <201112091517.23638.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 December 2011, Shawn Guo wrote:
> 
> From: Jamie Iles <jamie@jamieiles.com>
> 
> irqdomain support is used in interrupt controller drivers that may not
> have device tree support but only need the basic HW->Linux irq
> translation.  Rather than having each of these implement their own IRQ
> domain, allow them to use the simple ops.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: Rob Herring <robherring2@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'm fine with taking this through arm-soc with an Ack from Thomas.

	Arnd
