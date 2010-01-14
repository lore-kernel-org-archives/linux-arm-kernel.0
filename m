From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jan 2010 09:09:00 +0000
Subject: [PATCH - 2nd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <201001131730.24535.epeer@tmtservices.co.za>
References: <201001131730.24535.epeer@tmtservices.co.za>
Message-ID: <20100114090900.GA19197@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 05:30:24PM +0200, Edwin Peer wrote:
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/gpio.h>

Also this should be linux/gpio.h
