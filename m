From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Feb 2011 20:46:54 +0000
Subject: [PATCH 1/6] ARM: tegra: add tegra_gpio_table and tegra_gpio_config
In-Reply-To: <1298354117-19097-2-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-2-git-send-email-olof@lixom.net>
Message-ID: <20110222204654.GD29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 11:55:12PM -0600, Olof Johansson wrote:
>  #include <linux/kernel.h>
>  #include <mach/pinmux.h>
> +#include <mach/gpio.h>

linux/gpio.h please
