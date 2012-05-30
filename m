From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 30 May 2012 20:25:05 +0530
Subject: [RFC PATCH 3/5] drivers: misc: omap: add a new driver for ocp2scp
In-Reply-To: <1338375394-16268-4-git-send-email-kishon@ti.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
 <1338375394-16268-4-git-send-email-kishon@ti.com>
Message-ID: <CAMQu2gw8-ZuKqTVaqZtcvD4K5iGVPJKj9u9j4K8SFrUm7qb7fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 4:26 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Adds a new driver _ocp2scp_. This driver takes the responsibility of creating
> all the devices that is connected to OCP2SCP. In the case of OMAP4, USB2PHY
> is connected to ocp2scp.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
[...]

> +++ b/drivers/misc/omap-ocp2scp.c
> @@ -0,0 +1,135 @@
> +/*
> + * omap-ocp2scp.c - transform ocp interface protocol to scp protocol
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
s/2011/2012

[...]

> diff --git a/include/linux/platform_data/omap_ocp2scp.h b/include/linux/platform_data/omap_ocp2scp.h
> new file mode 100644
> index 0000000..dcbbf2a
> --- /dev/null
> +++ b/include/linux/platform_data/omap_ocp2scp.h
> @@ -0,0 +1,31 @@
> +/*
> + * omap_ocp2scp.h -- ocp2scp header file
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
Dito.
