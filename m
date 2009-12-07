From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2009 12:05:53 +0000
Subject: [patch 4/4] [ARM] mmp: support flint development board
In-Reply-To: <771cded00912062220u4cce8ccdy5a61fbe356c394cc@mail.gmail.com>
References: <771cded00912062220u4cce8ccdy5a61fbe356c394cc@mail.gmail.com>
Message-ID: <20091207120553.GC19348@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 01:20:43AM -0500, Haojian Zhuang wrote:
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/smc91x.h>
> +#include <linux/io.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/addr-map.h>
> +#include <mach/gpio.h>

linux/gpio.h
