From: rubini@unipv.it (Alessandro Rubini)
Date: Fri, 20 Jan 2012 23:33:47 +0100
Subject: [PATCH 29/31] ARM: amba: nomadik: use common amba device
 initializers
In-Reply-To: <E1RoApP-0005GE-D8@rmk-PC.arm.linux.org.uk>
References: <E1RoApP-0005GE-D8@rmk-PC.arm.linux.org.uk>
 <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <20120120223347.GA9523@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static AMBA_APB_DEVICE(uart0, "uart0", 0, NOMADIK_UART0_BASE,
> +	{ IRQ_UART0 }, NULL);

Acked-by: Alessandro Rubini <rubini@unipv.it>

thanks
/alessandro
