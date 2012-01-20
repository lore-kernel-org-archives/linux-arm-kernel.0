From: rubini@unipv.it (Alessandro Rubini)
Date: Fri, 20 Jan 2012 23:33:35 +0100
Subject: [PATCH 13/31] ARM: amba: nomadik: get rid of NO_IRQ initializers
In-Reply-To: <E1RoAkC-0005F9-GQ@rmk-PC.arm.linux.org.uk>
References: <E1RoAkC-0005F9-GQ@rmk-PC.arm.linux.org.uk>
 <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <20120120223335.GA9479@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -	.irq = {IRQ_UART0, NO_IRQ},
> +	.irq = {IRQ_UART0},

Acked-by: Alessandro Rubini <rubini@unipv.it>
