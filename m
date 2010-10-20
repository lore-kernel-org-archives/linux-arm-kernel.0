From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 20 Oct 2010 12:15:16 -0400 (EDT)
Subject: [PATCH 5/5] ARM: remove per-platform timex.h include files
In-Reply-To: <20101020045200.GB12979@mail.wantstofly.org>
References: <20101020045200.GB12979@mail.wantstofly.org>
Message-ID: <alpine.LFD.2.00.1010201214420.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Oct 2010, Lennert Buytenhek wrote:

> As they are now redundant.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/mach-aaec2000/include/mach/timex.h   |   18 -----
>  arch/arm/mach-at91/include/mach/timex.h       |   92 -------------------------
>  arch/arm/mach-bcmring/include/mach/timex.h    |   25 -------
>  arch/arm/mach-clps711x/include/mach/timex.h   |   23 ------
>  arch/arm/mach-cns3xxx/include/mach/timex.h    |   12 ---
>  arch/arm/mach-davinci/include/mach/timex.h    |   22 ------
>  arch/arm/mach-dove/include/mach/timex.h       |    9 ---
>  arch/arm/mach-ebsa110/include/mach/timex.h    |   19 -----
>  arch/arm/mach-ep93xx/include/mach/timex.h     |    5 --
>  arch/arm/mach-footbridge/include/mach/timex.h |   18 -----
>  arch/arm/mach-gemini/include/mach/timex.h     |   13 ----
>  arch/arm/mach-h720x/include/mach/timex.h      |   15 ----
>  arch/arm/mach-integrator/include/mach/timex.h |   26 -------
>  arch/arm/mach-iop13xx/include/mach/timex.h    |    1 -
>  arch/arm/mach-iop32x/include/mach/timex.h     |    6 --
>  arch/arm/mach-iop33x/include/mach/timex.h     |    6 --
>  arch/arm/mach-ixp2000/include/mach/timex.h    |   13 ----
>  arch/arm/mach-ixp23xx/include/mach/timex.h    |    7 --
>  arch/arm/mach-ixp4xx/include/mach/timex.h     |   15 ----
>  arch/arm/mach-kirkwood/include/mach/timex.h   |   10 ---
>  arch/arm/mach-ks8695/include/mach/timex.h     |   21 ------
>  arch/arm/mach-lh7a40x/include/mach/timex.h    |   17 -----
>  arch/arm/mach-loki/include/mach/timex.h       |   11 ---
>  arch/arm/mach-lpc32xx/include/mach/timex.h    |   28 --------
>  arch/arm/mach-mmp/include/mach/timex.h        |   13 ----
>  arch/arm/mach-msm/include/mach/timex.h        |   21 ------
>  arch/arm/mach-mv78xx0/include/mach/timex.h    |    9 ---
>  arch/arm/mach-netx/include/mach/timex.h       |   20 ------
>  arch/arm/mach-nomadik/include/mach/timex.h    |    6 --
>  arch/arm/mach-ns9xxx/include/mach/timex.h     |   20 ------
>  arch/arm/mach-nuc93x/include/mach/timex.h     |   25 -------
>  arch/arm/mach-omap1/include/mach/timex.h      |    5 --
>  arch/arm/mach-omap2/include/mach/timex.h      |    5 --
>  arch/arm/mach-orion5x/include/mach/timex.h    |   11 ---
>  arch/arm/mach-pnx4008/include/mach/timex.h    |   19 -----
>  arch/arm/mach-pxa/include/mach/timex.h        |   34 ---------
>  arch/arm/mach-realview/include/mach/timex.h   |   23 ------
>  arch/arm/mach-rpc/include/mach/timex.h        |   17 -----
>  arch/arm/mach-s3c2410/include/mach/timex.h    |   24 -------
>  arch/arm/mach-s3c24a0/include/mach/timex.h    |   18 -----
>  arch/arm/mach-s3c64xx/include/mach/timex.h    |   24 -------
>  arch/arm/mach-s5p6440/include/mach/timex.h    |   24 -------
>  arch/arm/mach-s5p6442/include/mach/timex.h    |   24 -------
>  arch/arm/mach-s5pc100/include/mach/timex.h    |   24 -------
>  arch/arm/mach-s5pv210/include/mach/timex.h    |   29 --------
>  arch/arm/mach-s5pv310/include/mach/timex.h    |   29 --------
>  arch/arm/mach-sa1100/include/mach/timex.h     |   12 ---
>  arch/arm/mach-shark/include/mach/timex.h      |    7 --
>  arch/arm/mach-shmobile/include/mach/timex.h   |    6 --
>  arch/arm/mach-spear3xx/include/mach/timex.h   |   19 -----
>  arch/arm/mach-spear6xx/include/mach/timex.h   |   19 -----
>  arch/arm/mach-tegra/include/mach/timex.h      |   26 -------
>  arch/arm/mach-u300/include/mach/timex.h       |   17 -----
>  arch/arm/mach-ux500/include/mach/timex.h      |    6 --
>  arch/arm/mach-versatile/include/mach/timex.h  |   23 ------
>  arch/arm/mach-vexpress/include/mach/timex.h   |   23 ------
>  arch/arm/mach-w90x900/include/mach/timex.h    |   25 -------
>  arch/arm/plat-mxc/include/mach/timex.h        |   33 ---------
>  arch/arm/plat-omap/include/plat/timex.h       |   41 -----------
>  arch/arm/plat-spear/include/plat/timex.h      |   19 -----
>  arch/arm/plat-stmp3xxx/include/mach/timex.h   |   20 ------
>  61 files changed, 0 insertions(+), 1152 deletions(-)
>  delete mode 100644 arch/arm/mach-aaec2000/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-bcmring/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-clps711x/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-cns3xxx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-davinci/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-dove/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-ebsa110/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-ep93xx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-footbridge/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-gemini/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-h720x/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-integrator/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-iop13xx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-iop32x/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-iop33x/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-ixp2000/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-ixp23xx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-ixp4xx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-ks8695/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-lh7a40x/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-loki/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-lpc32xx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-mmp/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-msm/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-mv78xx0/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-netx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-nomadik/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-ns9xxx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-nuc93x/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-omap1/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-omap2/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-orion5x/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-pnx4008/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-pxa/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-realview/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-rpc/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-s3c2410/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-s3c24a0/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-s5p6440/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-s5p6442/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-s5pc100/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-s5pv210/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-s5pv310/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-shark/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-shmobile/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-spear3xx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-spear6xx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-tegra/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-u300/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-ux500/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-versatile/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-vexpress/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-w90x900/include/mach/timex.h
>  delete mode 100644 arch/arm/plat-mxc/include/mach/timex.h
>  delete mode 100644 arch/arm/plat-omap/include/plat/timex.h
>  delete mode 100644 arch/arm/plat-spear/include/plat/timex.h
>  delete mode 100644 arch/arm/plat-stmp3xxx/include/mach/timex.h
> 
> diff --git a/arch/arm/mach-aaec2000/include/mach/timex.h b/arch/arm/mach-aaec2000/include/mach/timex.h
> deleted file mode 100644
> index 6c8edf4..0000000
> --- a/arch/arm/mach-aaec2000/include/mach/timex.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/*
> - *  arch/arm/mach-aaec2000/include/mach/timex.h
> - *
> - *  AAEC-2000 Architecture timex specification
> - *
> - *  Copyright (c) 2005 Nicolas Bellido Y Ortega
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2 as
> - *  published by the Free Software Foundation.
> - */
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -#define CLOCK_TICK_RATE		508000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-at91/include/mach/timex.h b/arch/arm/mach-at91/include/mach/timex.h
> deleted file mode 100644
> index 05a6e8a..0000000
> --- a/arch/arm/mach-at91/include/mach/timex.h
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -/*
> - * arch/arm/mach-at91/include/mach/timex.h
> - *
> - *  Copyright (C) 2003 SAN People
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -#include <mach/hardware.h>
> -
> -#if defined(CONFIG_ARCH_AT91RM9200)
> -
> -#define CLOCK_TICK_RATE		(AT91_SLOW_CLOCK)
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9260)
> -
> -#if defined(CONFIG_MACH_USB_A9260) || defined(CONFIG_MACH_QIL_A9260)
> -#define AT91SAM9_MASTER_CLOCK	90000000
> -#else
> -#define AT91SAM9_MASTER_CLOCK	99300000
> -#endif
> -
> -#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9261)
> -
> -#define AT91SAM9_MASTER_CLOCK	99300000
> -#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9G10)
> -
> -#define AT91SAM9_MASTER_CLOCK	133000000
> -#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9263)
> -
> -#if defined(CONFIG_MACH_USB_A9263)
> -#define AT91SAM9_MASTER_CLOCK	90000000
> -#else
> -#define AT91SAM9_MASTER_CLOCK	99959500
> -#endif
> -
> -#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9RL)
> -
> -#define AT91SAM9_MASTER_CLOCK	100000000
> -#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9G20)
> -
> -#define AT91SAM9_MASTER_CLOCK	132096000
> -#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9G45)
> -
> -#define AT91SAM9_MASTER_CLOCK	133333333
> -#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
> -
> -#elif defined(CONFIG_ARCH_AT91CAP9)
> -
> -#define AT91CAP9_MASTER_CLOCK	100000000
> -#define CLOCK_TICK_RATE		(AT91CAP9_MASTER_CLOCK/16)
> -
> -#elif defined(CONFIG_ARCH_AT91X40)
> -
> -#define AT91X40_MASTER_CLOCK	40000000
> -#define CLOCK_TICK_RATE		(AT91X40_MASTER_CLOCK)
> -
> -#elif defined(CONFIG_ARCH_AT572D940HF)
> -
> -#define AT572D940HF_MASTER_CLOCK	80000000
> -#define CLOCK_TICK_RATE		(AT572D940HF_MASTER_CLOCK/16)
> -
> -#endif
> -
> -#endif
> diff --git a/arch/arm/mach-bcmring/include/mach/timex.h b/arch/arm/mach-bcmring/include/mach/timex.h
> deleted file mode 100644
> index 40d033e..0000000
> --- a/arch/arm/mach-bcmring/include/mach/timex.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - *
> - *  Integrator architecture timex specifications
> - *
> - *  Copyright (C) 1999 ARM Limited
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -/*
> - * Specifies the number of ticks per second
> - */
> -#define CLOCK_TICK_RATE		100000 /* REG_SMT_TICKS_PER_SEC */
> diff --git a/arch/arm/mach-clps711x/include/mach/timex.h b/arch/arm/mach-clps711x/include/mach/timex.h
> deleted file mode 100644
> index ac8823c..0000000
> --- a/arch/arm/mach-clps711x/include/mach/timex.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/*
> - *  arch/arm/mach-clps711x/include/mach/timex.h
> - *
> - *  Prospector 720T architecture timex specifications
> - *
> - *  Copyright (C) 2000 Deep Blue Solutions Ltd.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#define CLOCK_TICK_RATE 512000
> diff --git a/arch/arm/mach-cns3xxx/include/mach/timex.h b/arch/arm/mach-cns3xxx/include/mach/timex.h
> deleted file mode 100644
> index 1fd0421..0000000
> --- a/arch/arm/mach-cns3xxx/include/mach/timex.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/*
> - * Cavium Networks architecture timex specifications
> - *
> - * Copyright 2003 ARM Limited
> - * Copyright 2008 Cavium Networks
> - *
> - * This file is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, Version 2, as
> - * published by the Free Software Foundation.
> - */
> -
> -#define CLOCK_TICK_RATE		(50000000 / 16)
> diff --git a/arch/arm/mach-davinci/include/mach/timex.h b/arch/arm/mach-davinci/include/mach/timex.h
> deleted file mode 100644
> index 9b88529..0000000
> --- a/arch/arm/mach-davinci/include/mach/timex.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/*
> - * DaVinci timer defines
> - *
> - * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
> - *
> - * 2007 (c) MontaVista Software, Inc. This file is licensed under
> - * the terms of the GNU General Public License version 2. This program
> - * is licensed "as is" without any warranty of any kind, whether express
> - * or implied.
> - */
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/*
> - * Alert: Not all timers of the DaVinci family run at a frequency of 27MHz,
> - * but we should be fine as long as CLOCK_TICK_RATE or LATCH (see include/
> - * linux/jiffies.h) are not used directly in code. Currently none of the
> - * code relevant to DaVinci platform depends on these values directly.
> - */
> -#define CLOCK_TICK_RATE 27000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H__ */
> diff --git a/arch/arm/mach-dove/include/mach/timex.h b/arch/arm/mach-dove/include/mach/timex.h
> deleted file mode 100644
> index 251d538..0000000
> --- a/arch/arm/mach-dove/include/mach/timex.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/*
> - * arch/arm/mach-dove/include/mach/timex.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#define CLOCK_TICK_RATE		(100 * HZ)
> diff --git a/arch/arm/mach-ebsa110/include/mach/timex.h b/arch/arm/mach-ebsa110/include/mach/timex.h
> deleted file mode 100644
> index 4fb43b2..0000000
> --- a/arch/arm/mach-ebsa110/include/mach/timex.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*
> - *  arch/arm/mach-ebsa110/include/mach/timex.h
> - *
> - *  Copyright (C) 1997, 1998 Russell King
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - *  EBSA110 architecture timex specifications
> - */
> -
> -/*
> - * On the EBSA, the clock ticks at weird rates.
> - * This is therefore not used to calculate the
> - * divisor.
> - */
> -#define CLOCK_TICK_RATE		47894000
> -
> diff --git a/arch/arm/mach-ep93xx/include/mach/timex.h b/arch/arm/mach-ep93xx/include/mach/timex.h
> deleted file mode 100644
> index 6b3503b..0000000
> --- a/arch/arm/mach-ep93xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -/*
> - * arch/arm/mach-ep93xx/include/mach/timex.h
> - */
> -
> -#define CLOCK_TICK_RATE		983040
> diff --git a/arch/arm/mach-footbridge/include/mach/timex.h b/arch/arm/mach-footbridge/include/mach/timex.h
> deleted file mode 100644
> index d0fea9d..0000000
> --- a/arch/arm/mach-footbridge/include/mach/timex.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/*
> - *  arch/arm/mach-footbridge/include/mach/timex.h
> - *
> - *  Copyright (C) 1998 Russell King
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - *  EBSA285 architecture timex specifications
> - */
> -
> -/*
> - * We assume a constant here; this satisfies the maths in linux/timex.h
> - * and linux/time.h.  CLOCK_TICK_RATE is actually system dependent, but
> - * this must be a constant.
> - */
> -#define CLOCK_TICK_RATE		(50000000/16)
> diff --git a/arch/arm/mach-gemini/include/mach/timex.h b/arch/arm/mach-gemini/include/mach/timex.h
> deleted file mode 100644
> index dc5690b..0000000
> --- a/arch/arm/mach-gemini/include/mach/timex.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/*
> - * Gemini timex specifications
> - *
> - * Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -/* When AHB bus frequency is 150MHz */
> -#define CLOCK_TICK_RATE	38000000
> diff --git a/arch/arm/mach-h720x/include/mach/timex.h b/arch/arm/mach-h720x/include/mach/timex.h
> deleted file mode 100644
> index 3f2f447..0000000
> --- a/arch/arm/mach-h720x/include/mach/timex.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/*
> - * arch/arm/mach-h720x/include/mach/timex.h
> - * Copyright (C) 2000 Jungjun Kim, Hynix Semiconductor Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifndef __ASM_ARCH_TIMEX
> -#define __ASM_ARCH_TIMEX
> -
> -#define CLOCK_TICK_RATE		3686400
> -
> -#endif
> diff --git a/arch/arm/mach-integrator/include/mach/timex.h b/arch/arm/mach-integrator/include/mach/timex.h
> deleted file mode 100644
> index 1dcb420..0000000
> --- a/arch/arm/mach-integrator/include/mach/timex.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - *  arch/arm/mach-integrator/include/mach/timex.h
> - *
> - *  Integrator architecture timex specifications
> - *
> - *  Copyright (C) 1999 ARM Limited
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -/*
> - * ??
> - */
> -#define CLOCK_TICK_RATE		(50000000 / 16)
> diff --git a/arch/arm/mach-iop13xx/include/mach/timex.h b/arch/arm/mach-iop13xx/include/mach/timex.h
> deleted file mode 100644
> index 45fb274..0000000
> --- a/arch/arm/mach-iop13xx/include/mach/timex.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#define CLOCK_TICK_RATE (100 * HZ)
> diff --git a/arch/arm/mach-iop32x/include/mach/timex.h b/arch/arm/mach-iop32x/include/mach/timex.h
> deleted file mode 100644
> index 7262ab8..0000000
> --- a/arch/arm/mach-iop32x/include/mach/timex.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -/*
> - * arch/arm/mach-iop32x/include/mach/timex.h
> - *
> - * IOP32x architecture timex specifications
> - */
> -#define CLOCK_TICK_RATE		(100 * HZ)
> diff --git a/arch/arm/mach-iop33x/include/mach/timex.h b/arch/arm/mach-iop33x/include/mach/timex.h
> deleted file mode 100644
> index 54c5890..0000000
> --- a/arch/arm/mach-iop33x/include/mach/timex.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -/*
> - * arch/arm/mach-iop33x/include/mach/timex.h
> - *
> - * IOP3xx architecture timex specifications
> - */
> -#define CLOCK_TICK_RATE		(100 * HZ)
> diff --git a/arch/arm/mach-ixp2000/include/mach/timex.h b/arch/arm/mach-ixp2000/include/mach/timex.h
> deleted file mode 100644
> index 835e659..0000000
> --- a/arch/arm/mach-ixp2000/include/mach/timex.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/*
> - * arch/arm/mach-ixp2000/include/mach/timex.h
> - *
> - * IXP2000 architecture timex specifications
> - */
> -
> -
> -/*
> - * Default clock is 50MHz APB, but platform code can override this
> - */
> -#define CLOCK_TICK_RATE	50000000
> -
> -
> diff --git a/arch/arm/mach-ixp23xx/include/mach/timex.h b/arch/arm/mach-ixp23xx/include/mach/timex.h
> deleted file mode 100644
> index e341e9c..0000000
> --- a/arch/arm/mach-ixp23xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -/*
> - * arch/arm/mach-ixp23xx/include/mach/timex.h
> - *
> - * XScale architecture timex specifications
> - */
> -
> -#define CLOCK_TICK_RATE 75000000
> diff --git a/arch/arm/mach-ixp4xx/include/mach/timex.h b/arch/arm/mach-ixp4xx/include/mach/timex.h
> deleted file mode 100644
> index 2c3f93c..0000000
> --- a/arch/arm/mach-ixp4xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/*
> - * arch/arm/mach-ixp4xx/include/mach/timex.h
> - * 
> - */
> -
> -#include <mach/hardware.h>
> -
> -/*
> - * We use IXP425 General purpose timer for our timer needs, it runs at 
> - * 66.66... MHz. We do a convulted calculation of CLOCK_TICK_RATE b/c the
> - * timer register ignores the bottom 2 bits of the LATCH value.
> - */
> -#define FREQ 66666000
> -#define CLOCK_TICK_RATE (((FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
> -
> diff --git a/arch/arm/mach-kirkwood/include/mach/timex.h b/arch/arm/mach-kirkwood/include/mach/timex.h
> deleted file mode 100644
> index c923cd1..0000000
> --- a/arch/arm/mach-kirkwood/include/mach/timex.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -/*
> - * arch/arm/mach-kirkwood/include/mach/timex.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#define CLOCK_TICK_RATE		(100 * HZ)
> -
> diff --git a/arch/arm/mach-ks8695/include/mach/timex.h b/arch/arm/mach-ks8695/include/mach/timex.h
> deleted file mode 100644
> index 10f7163..0000000
> --- a/arch/arm/mach-ks8695/include/mach/timex.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/*
> - * arch/arm/mach-ks8695/include/mach/timex.h
> - *
> - * Copyright (C) 2006 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * KS8695 - Time Parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -#include <mach/hardware.h>
> -
> -#define CLOCK_TICK_RATE 	KS8695_CLOCK_RATE
> -
> -#endif
> diff --git a/arch/arm/mach-lh7a40x/include/mach/timex.h b/arch/arm/mach-lh7a40x/include/mach/timex.h
> deleted file mode 100644
> index 08028ce..0000000
> --- a/arch/arm/mach-lh7a40x/include/mach/timex.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* arch/arm/mach-lh7a40x/include/mach/timex.h
> - *
> - *  Copyright (C) 2004 Coastal Environmental Systems
> - *
> - *  This program is free software; you can redistribute it and/or
> - *  modify it under the terms of the GNU General Public License
> - *  version 2 as published by the Free Software Foundation.
> - *
> - */
> -
> -#include <mach/constants.h>
> -
> -#define CLOCK_TICK_RATE		(PLL_CLOCK/6/16)
> -
> -/*
> -#define CLOCK_TICK_RATE		3686400
> -*/
> diff --git a/arch/arm/mach-loki/include/mach/timex.h b/arch/arm/mach-loki/include/mach/timex.h
> deleted file mode 100644
> index 9df2109..0000000
> --- a/arch/arm/mach-loki/include/mach/timex.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -/*
> - * arch/arm/mach-loki/include/mach/timex.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#define CLOCK_TICK_RATE		(100 * HZ)
> -
> -#define LOKI_TCLK		180000000
> diff --git a/arch/arm/mach-lpc32xx/include/mach/timex.h b/arch/arm/mach-lpc32xx/include/mach/timex.h
> deleted file mode 100644
> index 8d4066b..0000000
> --- a/arch/arm/mach-lpc32xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/*
> - * arch/arm/mach-lpc32xx/include/mach/timex.h
> - *
> - * Author: Kevin Wells <kevin.wells@nxp.com>
> - *
> - * Copyright (C) 2010 NXP Semiconductors
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/*
> - * Rate in Hz of the main system oscillator. This value should match
> - * the value 'MAIN_OSC_FREQ' in platform.h
> - */
> -#define CLOCK_TICK_RATE	13000000
> -
> -#endif
> diff --git a/arch/arm/mach-mmp/include/mach/timex.h b/arch/arm/mach-mmp/include/mach/timex.h
> deleted file mode 100644
> index 70c9f1d..0000000
> --- a/arch/arm/mach-mmp/include/mach/timex.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/*
> - * linux/arch/arm/mach-mmp/include/mach/timex.h
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifdef CONFIG_CPU_MMP2
> -#define CLOCK_TICK_RATE		6500000
> -#else
> -#define CLOCK_TICK_RATE		3250000
> -#endif
> diff --git a/arch/arm/mach-msm/include/mach/timex.h b/arch/arm/mach-msm/include/mach/timex.h
> deleted file mode 100644
> index a62e6b2..0000000
> --- a/arch/arm/mach-msm/include/mach/timex.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* arch/arm/mach-msm/include/mach/timex.h
> - *
> - * Copyright (C) 2007 Google, Inc.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -#ifndef __ASM_ARCH_MSM_TIMEX_H
> -#define __ASM_ARCH_MSM_TIMEX_H
> -
> -#define CLOCK_TICK_RATE		1000000
> -
> -#endif
> diff --git a/arch/arm/mach-mv78xx0/include/mach/timex.h b/arch/arm/mach-mv78xx0/include/mach/timex.h
> deleted file mode 100644
> index 0e8c443..0000000
> --- a/arch/arm/mach-mv78xx0/include/mach/timex.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/*
> - * arch/arm/mach-mv78xx0/include/mach/timex.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#define CLOCK_TICK_RATE		(100 * HZ)
> diff --git a/arch/arm/mach-netx/include/mach/timex.h b/arch/arm/mach-netx/include/mach/timex.h
> deleted file mode 100644
> index 1120dd0..0000000
> --- a/arch/arm/mach-netx/include/mach/timex.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/*
> - * arch/arm/mach-netx/include/mach/timex.h
> - *
> - * Copyright (C) 2005 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2
> - * as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#define CLOCK_TICK_RATE 100000000
> diff --git a/arch/arm/mach-nomadik/include/mach/timex.h b/arch/arm/mach-nomadik/include/mach/timex.h
> deleted file mode 100644
> index 318b889..0000000
> --- a/arch/arm/mach-nomadik/include/mach/timex.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -#define CLOCK_TICK_RATE         2400000
> -
> -#endif
> diff --git a/arch/arm/mach-ns9xxx/include/mach/timex.h b/arch/arm/mach-ns9xxx/include/mach/timex.h
> deleted file mode 100644
> index 734a8d8..0000000
> --- a/arch/arm/mach-ns9xxx/include/mach/timex.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/*
> - * arch/arm/mach-ns9xxx/include/mach/timex.h
> - *
> - * Copyright (C) 2005-2006 by Digi International Inc.
> - * All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - */
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/*
> - * value for CLOCK_TICK_RATE stolen from arch/arm/mach-s3c2410/include/mach/timex.h.
> - * See there for an explanation.
> - */
> -#define CLOCK_TICK_RATE         12000000
> -
> -#endif /* ifndef __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-nuc93x/include/mach/timex.h b/arch/arm/mach-nuc93x/include/mach/timex.h
> deleted file mode 100644
> index 0c719cc..0000000
> --- a/arch/arm/mach-nuc93x/include/mach/timex.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - * arch/arm/mach-nuc93x/include/mach/timex.h
> - *
> - * Copyright (c) 2008 Nuvoton technology corporation
> - * All rights reserved.
> - *
> - * Wan ZongShun <mcuos.com@gmail.com>
> - *
> - * Based on arch/arm/mach-s3c2410/include/mach/timex.h
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - */
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/* CLOCK_TICK_RATE Now, I don't use it. */
> -
> -#define CLOCK_TICK_RATE 27000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-omap1/include/mach/timex.h b/arch/arm/mach-omap1/include/mach/timex.h
> deleted file mode 100644
> index 4793790..0000000
> --- a/arch/arm/mach-omap1/include/mach/timex.h
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -/*
> - * arch/arm/mach-omap1/include/mach/timex.h
> - */
> -
> -#include <plat/timex.h>
> diff --git a/arch/arm/mach-omap2/include/mach/timex.h b/arch/arm/mach-omap2/include/mach/timex.h
> deleted file mode 100644
> index de9f8fc..0000000
> --- a/arch/arm/mach-omap2/include/mach/timex.h
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -/*
> - * arch/arm/mach-omap2/include/mach/timex.h
> - */
> -
> -#include <plat/timex.h>
> diff --git a/arch/arm/mach-orion5x/include/mach/timex.h b/arch/arm/mach-orion5x/include/mach/timex.h
> deleted file mode 100644
> index 4c69820..0000000
> --- a/arch/arm/mach-orion5x/include/mach/timex.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -/*
> - * arch/arm/mach-orion5x/include/mach/timex.h
> - *
> - * Tzachi Perelstein <tzachi@marvell.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#define CLOCK_TICK_RATE		(100 * HZ)
> diff --git a/arch/arm/mach-pnx4008/include/mach/timex.h b/arch/arm/mach-pnx4008/include/mach/timex.h
> deleted file mode 100644
> index b383c7d..0000000
> --- a/arch/arm/mach-pnx4008/include/mach/timex.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*
> - * arch/arm/mach-pnx4008/include/mach/timex.h
> - *
> - * PNX4008 timers header file
> - *
> - * Author: Dmitry Chigirev <source@mvista.com>
> - *
> - * 2005 (c) MontaVista Software, Inc. This file is licensed under
> - * the terms of the GNU General Public License version 2. This program
> - * is licensed "as is" without any warranty of any kind, whether express
> - * or implied.
> - */
> -
> -#ifndef __PNX4008_TIMEX_H
> -#define __PNX4008_TIMEX_H
> -
> -#define CLOCK_TICK_RATE		1000000
> -
> -#endif
> diff --git a/arch/arm/mach-pxa/include/mach/timex.h b/arch/arm/mach-pxa/include/mach/timex.h
> deleted file mode 100644
> index af6760a..0000000
> --- a/arch/arm/mach-pxa/include/mach/timex.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * arch/arm/mach-pxa/include/mach/timex.h
> - *
> - * Author:	Nicolas Pitre
> - * Created:	Jun 15, 2001
> - * Copyright:	MontaVista Software Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -/* Various drivers are still using the constant of CLOCK_TICK_RATE, for
> - * those drivers to at least work, the definition is provided here.
> - *
> - * NOTE: this is no longer accurate when multiple processors and boards
> - * are selected, newer drivers should not depend on this any more.  Use
> - * either the clocksource/clockevent or get this at run-time by calling
> - * get_clock_tick_rate() (as defined in generic.c).
> - */
> -
> -#if defined(CONFIG_PXA25x)
> -/* PXA250/210 timer base */
> -#define CLOCK_TICK_RATE 3686400
> -#elif defined(CONFIG_PXA27x)
> -/* PXA27x timer base */
> -#ifdef CONFIG_MACH_MAINSTONE
> -#define CLOCK_TICK_RATE 3249600
> -#else
> -#define CLOCK_TICK_RATE 3250000
> -#endif
> -#else
> -#define CLOCK_TICK_RATE 3250000
> -#endif
> diff --git a/arch/arm/mach-realview/include/mach/timex.h b/arch/arm/mach-realview/include/mach/timex.h
> deleted file mode 100644
> index 4eeb069..0000000
> --- a/arch/arm/mach-realview/include/mach/timex.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/*
> - *  arch/arm/mach-realview/include/mach/timex.h
> - *
> - *  RealView architecture timex specifications
> - *
> - *  Copyright (C) 2003 ARM Limited
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#define CLOCK_TICK_RATE		(50000000 / 16)
> diff --git a/arch/arm/mach-rpc/include/mach/timex.h b/arch/arm/mach-rpc/include/mach/timex.h
> deleted file mode 100644
> index dd75e73..0000000
> --- a/arch/arm/mach-rpc/include/mach/timex.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/*
> - *  arch/arm/mach-rpc/include/mach/timex.h
> - *
> - *  Copyright (C) 1997, 1998 Russell King
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - *  RiscPC architecture timex specifications
> - */
> -
> -/*
> - * On the RiscPC, the clock ticks at 2MHz.
> - */
> -#define CLOCK_TICK_RATE		2000000
> -
> diff --git a/arch/arm/mach-s3c2410/include/mach/timex.h b/arch/arm/mach-s3c2410/include/mach/timex.h
> deleted file mode 100644
> index fe9ca1f..0000000
> --- a/arch/arm/mach-s3c2410/include/mach/timex.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* arch/arm/mach-s3c2410/include/mach/timex.h
> - *
> - * Copyright (c) 2003-2005 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * S3C2410 - time parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
> - * a variable is useless. It seems as long as we make our timers an
> - * exact multiple of HZ, any value that makes a 1->1 correspondence
> - * for the time conversion functions to/from jiffies is acceptable.
> -*/
> -
> -#define CLOCK_TICK_RATE 12000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-s3c24a0/include/mach/timex.h b/arch/arm/mach-s3c24a0/include/mach/timex.h
> deleted file mode 100644
> index 9857342..0000000
> --- a/arch/arm/mach-s3c24a0/include/mach/timex.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* linux/arch/arm/mach-s3c24a0/include/mach/timex.h
> - *
> - * Copyright (c) 2008 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * S3C2410 - time parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -#define CLOCK_TICK_RATE 12000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-s3c64xx/include/mach/timex.h b/arch/arm/mach-s3c64xx/include/mach/timex.h
> deleted file mode 100644
> index fb2e8cd..0000000
> --- a/arch/arm/mach-s3c64xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* arch/arm/mach-s3c64xx/include/mach/timex.h
> - *
> - * Copyright (c) 2003-2005 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * S3C6400 - time parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
> - * a variable is useless. It seems as long as we make our timers an
> - * exact multiple of HZ, any value that makes a 1->1 correspondence
> - * for the time conversion functions to/from jiffies is acceptable.
> -*/
> -
> -#define CLOCK_TICK_RATE 12000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-s5p6440/include/mach/timex.h b/arch/arm/mach-s5p6440/include/mach/timex.h
> deleted file mode 100644
> index fb2e8cd..0000000
> --- a/arch/arm/mach-s5p6440/include/mach/timex.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* arch/arm/mach-s3c64xx/include/mach/timex.h
> - *
> - * Copyright (c) 2003-2005 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * S3C6400 - time parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
> - * a variable is useless. It seems as long as we make our timers an
> - * exact multiple of HZ, any value that makes a 1->1 correspondence
> - * for the time conversion functions to/from jiffies is acceptable.
> -*/
> -
> -#define CLOCK_TICK_RATE 12000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-s5p6442/include/mach/timex.h b/arch/arm/mach-s5p6442/include/mach/timex.h
> deleted file mode 100644
> index ff8f2fc..0000000
> --- a/arch/arm/mach-s5p6442/include/mach/timex.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* arch/arm/mach-s5p6442/include/mach/timex.h
> - *
> - * Copyright (c) 2003-2010 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * S5P6442 - time parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
> - * a variable is useless. It seems as long as we make our timers an
> - * exact multiple of HZ, any value that makes a 1->1 correspondence
> - * for the time conversion functions to/from jiffies is acceptable.
> -*/
> -
> -#define CLOCK_TICK_RATE 12000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-s5pc100/include/mach/timex.h b/arch/arm/mach-s5pc100/include/mach/timex.h
> deleted file mode 100644
> index 47ffb17..0000000
> --- a/arch/arm/mach-s5pc100/include/mach/timex.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* arch/arm/mach-s5pc100/include/mach/timex.h
> - *
> - * Copyright (c) 2003-2005 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * S3C6400 - time parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
> - * a variable is useless. It seems as long as we make our timers an
> - * exact multiple of HZ, any value that makes a 1->1 correspondence
> - * for the time conversion functions to/from jiffies is acceptable.
> -*/
> -
> -#define CLOCK_TICK_RATE 12000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-s5pv210/include/mach/timex.h b/arch/arm/mach-s5pv210/include/mach/timex.h
> deleted file mode 100644
> index 73dc854..0000000
> --- a/arch/arm/mach-s5pv210/include/mach/timex.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/* linux/arch/arm/mach-s5pv210/include/mach/timex.h
> - *
> - * Copyright (c) 2003-2010 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com/
> - *
> - * Based on arch/arm/mach-s5p6442/include/mach/timex.h
> - *
> - * S5PV210 - time parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H __FILE__
> -
> -/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
> - * a variable is useless. It seems as long as we make our timers an
> - * exact multiple of HZ, any value that makes a 1->1 correspondence
> - * for the time conversion functions to/from jiffies is acceptable.
> -*/
> -
> -#define CLOCK_TICK_RATE 12000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-s5pv310/include/mach/timex.h b/arch/arm/mach-s5pv310/include/mach/timex.h
> deleted file mode 100644
> index bd2359b..0000000
> --- a/arch/arm/mach-s5pv310/include/mach/timex.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/* linux/arch/arm/mach-s5pv310/include/mach/timex.h
> - *
> - * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com/
> - *
> - * Copyright (c) 2003-2010 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * Based on arch/arm/mach-s5p6442/include/mach/timex.h
> - *
> - * S5PV310 - time parameters
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H __FILE__
> -
> -/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
> - * a variable is useless. It seems as long as we make our timers an
> - * exact multiple of HZ, any value that makes a 1->1 correspondence
> - * for the time conversion functions to/from jiffies is acceptable.
> -*/
> -
> -#define CLOCK_TICK_RATE 12000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/mach-sa1100/include/mach/timex.h b/arch/arm/mach-sa1100/include/mach/timex.h
> deleted file mode 100644
> index 7a5d017..0000000
> --- a/arch/arm/mach-sa1100/include/mach/timex.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/*
> - * arch/arm/mach-sa1100/include/mach/timex.h
> - *
> - * SA1100 architecture timex specifications
> - *
> - * Copyright (C) 1998 
> - */
> -
> -/*
> - * SA1100 timer
> - */
> -#define CLOCK_TICK_RATE		3686400
> diff --git a/arch/arm/mach-shark/include/mach/timex.h b/arch/arm/mach-shark/include/mach/timex.h
> deleted file mode 100644
> index bb6eeae..0000000
> --- a/arch/arm/mach-shark/include/mach/timex.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -/*
> - * arch/arm/mach-shark/include/mach/timex.h
> - *
> - * by Alexander Schulz
> - */
> -
> -#define CLOCK_TICK_RATE 1193180
> diff --git a/arch/arm/mach-shmobile/include/mach/timex.h b/arch/arm/mach-shmobile/include/mach/timex.h
> deleted file mode 100644
> index ae0d8d8..0000000
> --- a/arch/arm/mach-shmobile/include/mach/timex.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#ifndef __ASM_MACH_TIMEX_H
> -#define __ASM_MACH_TIMEX_H
> -
> -#define CLOCK_TICK_RATE		1193180 /* unused i8253 PIT value */
> -
> -#endif /* __ASM_MACH_TIMEX_H */
> diff --git a/arch/arm/mach-spear3xx/include/mach/timex.h b/arch/arm/mach-spear3xx/include/mach/timex.h
> deleted file mode 100644
> index a38cc9d..0000000
> --- a/arch/arm/mach-spear3xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*
> - * arch/arm/mach-spear3xx/include/mach/timex.h
> - *
> - * SPEAr3XX machine family specific timex definitions
> - *
> - * Copyright (C) 2009 ST Microelectronics
> - * Viresh Kumar<viresh.kumar@st.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __MACH_TIMEX_H
> -#define __MACH_TIMEX_H
> -
> -#include <plat/timex.h>
> -
> -#endif /* __MACH_TIMEX_H */
> diff --git a/arch/arm/mach-spear6xx/include/mach/timex.h b/arch/arm/mach-spear6xx/include/mach/timex.h
> deleted file mode 100644
> index ac1c5b0..0000000
> --- a/arch/arm/mach-spear6xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*
> - * arch/arm/mach-spear6xx/include/mach/timex.h
> - *
> - * SPEAr6XX machine family specific timex definitions
> - *
> - * Copyright (C) 2009 ST Microelectronics
> - * Rajeev Kumar<rajeev-dlh.kumar@st.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __MACH_TIMEX_H
> -#define __MACH_TIMEX_H
> -
> -#include <plat/timex.h>
> -
> -#endif	/* __MACH_TIMEX_H */
> diff --git a/arch/arm/mach-tegra/include/mach/timex.h b/arch/arm/mach-tegra/include/mach/timex.h
> deleted file mode 100644
> index a44ccbd..0000000
> --- a/arch/arm/mach-tegra/include/mach/timex.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * arch/arm/mach-tegra/include/mach/timex.h
> - *
> - * Copyright (C) 2010 Google, Inc.
> - *
> - * Author:
> - *	Colin Cross <ccross@google.com>
> - *	Erik Gilling <konkers@google.com>
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -#ifndef __MACH_TEGRA_TIMEX_H
> -#define __MACH_TEGRA_TIMEX_H
> -
> -#define CLOCK_TICK_RATE		1000000
> -
> -#endif
> diff --git a/arch/arm/mach-u300/include/mach/timex.h b/arch/arm/mach-u300/include/mach/timex.h
> deleted file mode 100644
> index f233b72..0000000
> --- a/arch/arm/mach-u300/include/mach/timex.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/*
> - *
> - * arch/arm/mach-u300/include/mach/timex.h
> - *
> - *
> - * Copyright (C) 2006-2009 ST-Ericsson AB
> - * License terms: GNU General Public License (GPL) version 2
> - * Platform tick rate definition.
> - * Author: Linus Walleij <linus.walleij@stericsson.com>
> - */
> -#ifndef __MACH_TIMEX_H
> -#define __MACH_TIMEX_H
> -
> -/* This is for the APP OS GP1 (General Purpose 1) timer */
> -#define CLOCK_TICK_RATE		1000000
> -
> -#endif
> diff --git a/arch/arm/mach-ux500/include/mach/timex.h b/arch/arm/mach-ux500/include/mach/timex.h
> deleted file mode 100644
> index d0942c1..0000000
> --- a/arch/arm/mach-ux500/include/mach/timex.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -#define CLOCK_TICK_RATE		110000000
> -
> -#endif
> diff --git a/arch/arm/mach-versatile/include/mach/timex.h b/arch/arm/mach-versatile/include/mach/timex.h
> deleted file mode 100644
> index 426199b1..0000000
> --- a/arch/arm/mach-versatile/include/mach/timex.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/*
> - *  arch/arm/mach-versatile/include/mach/timex.h
> - *
> - *  Versatile architecture timex specifications
> - *
> - *  Copyright (C) 2003 ARM Limited
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#define CLOCK_TICK_RATE		(50000000 / 16)
> diff --git a/arch/arm/mach-vexpress/include/mach/timex.h b/arch/arm/mach-vexpress/include/mach/timex.h
> deleted file mode 100644
> index 00029ba..0000000
> --- a/arch/arm/mach-vexpress/include/mach/timex.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/*
> - *  arch/arm/mach-vexpress/include/mach/timex.h
> - *
> - *  RealView architecture timex specifications
> - *
> - *  Copyright (C) 2003 ARM Limited
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#define CLOCK_TICK_RATE		(50000000 / 16)
> diff --git a/arch/arm/mach-w90x900/include/mach/timex.h b/arch/arm/mach-w90x900/include/mach/timex.h
> deleted file mode 100644
> index 164dce0..0000000
> --- a/arch/arm/mach-w90x900/include/mach/timex.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - * arch/arm/mach-w90x900/include/mach/timex.h
> - *
> - * Copyright (c) 2008 Nuvoton technology corporation
> - * All rights reserved.
> - *
> - * Wan ZongShun <mcuos.com@gmail.com>
> - *
> - * Based on arch/arm/mach-s3c2410/include/mach/timex.h
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - */
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -/* CLOCK_TICK_RATE Now, I don't use it. */
> -
> -#define CLOCK_TICK_RATE 15000000
> -
> -#endif /* __ASM_ARCH_TIMEX_H */
> diff --git a/arch/arm/plat-mxc/include/mach/timex.h b/arch/arm/plat-mxc/include/mach/timex.h
> deleted file mode 100644
> index 2d96246..0000000
> --- a/arch/arm/plat-mxc/include/mach/timex.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/*
> - *  Copyright (C) 1999 ARM Limited
> - * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#ifndef __ASM_ARCH_MXC_TIMEX_H__
> -#define __ASM_ARCH_MXC_TIMEX_H__
> -
> -#if defined CONFIG_ARCH_MX1
> -#define CLOCK_TICK_RATE		16000000
> -#elif defined CONFIG_ARCH_MX2
> -#define CLOCK_TICK_RATE		13300000
> -#elif defined CONFIG_ARCH_MX3
> -#define CLOCK_TICK_RATE		16625000
> -#elif defined CONFIG_ARCH_MX25
> -#define CLOCK_TICK_RATE		16000000
> -#elif defined CONFIG_ARCH_MX5
> -#define CLOCK_TICK_RATE		8000000
> -#elif defined CONFIG_ARCH_MXC91231
> -#define CLOCK_TICK_RATE		13000000
> -#endif
> -
> -#endif				/* __ASM_ARCH_MXC_TIMEX_H__ */
> diff --git a/arch/arm/plat-omap/include/plat/timex.h b/arch/arm/plat-omap/include/plat/timex.h
> deleted file mode 100644
> index 6d35767..0000000
> --- a/arch/arm/plat-omap/include/plat/timex.h
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/*
> - * arch/arm/plat-omap/include/mach/timex.h
> - *
> - * Copyright (C) 2000 RidgeRun, Inc.
> - * Author:  Greg Lonnon <glonnon@ridgerun.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the
> - * Free Software Foundation; either version 2 of the License, or (at your
> - * option) any later version.
> - *
> - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
> - * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> - * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - * You should have received a copy of the  GNU General Public License along
> - * with this program; if not, write  to the Free Software Foundation, Inc.,
> - * 675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#if !defined(__ASM_ARCH_OMAP_TIMEX_H)
> -#define __ASM_ARCH_OMAP_TIMEX_H
> -
> -/*
> - * OMAP 32KHz timer updates time one jiffie at a time from a secondary timer,
> - * and that's why the CLOCK_TICK_RATE is not 32768.
> - */
> -#ifdef CONFIG_OMAP_32K_TIMER
> -#define CLOCK_TICK_RATE		(CONFIG_OMAP_32K_TIMER_HZ)
> -#else
> -#define CLOCK_TICK_RATE		(HZ * 100000UL)
> -#endif
> -
> -#endif /* __ASM_ARCH_OMAP_TIMEX_H */
> diff --git a/arch/arm/plat-spear/include/plat/timex.h b/arch/arm/plat-spear/include/plat/timex.h
> deleted file mode 100644
> index 914d09d..0000000
> --- a/arch/arm/plat-spear/include/plat/timex.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*
> - * arch/arm/plat-spear/include/plat/timex.h
> - *
> - * SPEAr platform specific timex definitions
> - *
> - * Copyright (C) 2009 ST Microelectronics
> - * Viresh Kumar<viresh.kumar@st.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __PLAT_TIMEX_H
> -#define __PLAT_TIMEX_H
> -
> -#define CLOCK_TICK_RATE			48000000
> -
> -#endif /* __PLAT_TIMEX_H */
> diff --git a/arch/arm/plat-stmp3xxx/include/mach/timex.h b/arch/arm/plat-stmp3xxx/include/mach/timex.h
> deleted file mode 100644
> index 3373985..0000000
> --- a/arch/arm/plat-stmp3xxx/include/mach/timex.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/*
> - * Copyright (C) 1999 ARM Limited
> - *
> - * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
> - * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
> - */
> -
> -/*
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 or later at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> -
> -/*
> - * System time clock is sourced from the 32k clock
> - */
> -#define CLOCK_TICK_RATE		(32768)
> -- 
> 1.7.2.3
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
