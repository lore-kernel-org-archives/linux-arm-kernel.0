From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 12 Mar 2013 00:51:30 -0700 (PDT)
Subject: [PATCH 04/04] ARM: shmobile: APE6EVM support
In-Reply-To: <20130312045637.19701.62477.sendpatchset@w520>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <20130312045637.19701.62477.sendpatchset@w520>
Message-ID: <87li9trr7l.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Magnus

I already sent Reviewed-by, but...

> @@ -0,0 +1,40 @@
> +/*
> + * APE6EVM board support
> + *
> + * Copyright (C) 2013  Renesas Solutions Corp.
> + * Copyright (C) 2013  Magnus Damm
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/irqchip.h>
> +#include <mach/common.h>
> +#include <mach/r8a73a4.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>

There are too many include here,
and not in alphabetical order :)

Best regards
---
Kuninori Morimoto
