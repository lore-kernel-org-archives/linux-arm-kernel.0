From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Apr 2010 20:44:54 +0100
Subject: [PATCH 2.6.34-rc4 1/8] mx5: Add registration of GPIOs for MX51
	Babbage board.
In-Reply-To: <1271175030-3635-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1271175030-3635-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100413194454.GB6289@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 13, 2010 at 11:10:24AM -0500, Dinh.Nguyen at freescale.com wrote:
> diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
> index d6fd396..73f2342 100644
> --- a/arch/arm/mach-mx5/devices.c
> +++ b/arch/arm/mach-mx5/devices.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright 2009 Amit Kucheria <amit.kucheria@canonical.com>
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
>   *
>   * The code contained herein is licensed under the GNU General Public
>   * License. You may obtain a copy of the GNU General Public License
> @@ -11,7 +12,9 @@
>  
>  #include <linux/platform_device.h>
>  #include <mach/hardware.h>
> +#include <mach/gpio.h>

linux/gpio.h
