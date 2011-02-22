From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Feb 2011 20:48:21 +0000
Subject: [PATCH 6/6] ARM: tegra: add seaboard, wario and kaen boards
In-Reply-To: <1298354117-19097-7-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-7-git-send-email-olof@lixom.net>
Message-ID: <20110222204821.GE29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 11:55:17PM -0600, Olof Johansson wrote:
> +++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
> @@ -0,0 +1,179 @@
> +/*
> + * Copyright (C) 2010 NVIDIA Corporation
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include <mach/pinmux.h>
> +#include <mach/pinmux-t2.h>
> +#include <mach/gpio.h>

Another linux/gpio.h please.
