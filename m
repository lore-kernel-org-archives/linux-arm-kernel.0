From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2011 15:24:38 +0000
Subject: [PATCH 1/3] Add support for mini-box.com picoSAM9G45 board
In-Reply-To: <1320073010-19549-1-git-send-email-npavel@mini-box.com>
References: <1320073010-19549-1-git-send-email-npavel@mini-box.com>
Message-ID: <20111031152438.GA10576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 04:56:48PM +0200, Nicu Pavel wrote:
> +#include <mach/hardware.h>
> +#include <video/atmel_lcdc.h>
> +
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/irq.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/irq.h>
> +
> +#include <mach/board.h>
> +#include <mach/gpio.h>

Noooooooo.  asm/gpio.h please.
