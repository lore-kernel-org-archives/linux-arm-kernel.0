From: joel@jms.id.au (Joel Stanley)
Date: Mon, 15 Jan 2018 14:31:27 -0600
Subject: [patch v16 3/4] Documentation: jtag: Add bindings for Aspeed SoC
 24xx and 25xx families JTAG master driver
In-Reply-To: <1515776909-29894-4-git-send-email-oleksandrs@mellanox.com>
References: <1515776909-29894-1-git-send-email-oleksandrs@mellanox.com>
 <1515776909-29894-4-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CACPK8XejAoSfQhTWHbzm4jX7A-tau1Oijm2qeWP+Gwz=PU8+tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 11:08 AM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:
> It has been tested on Mellanox system with BMC equipped with
> Aspeed 2520 SoC for programming CPLD devices.
>
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> Acked-by: Rob Herring <robh@kernel.org>

For the device tree bindings:

Acked-by: Joel Stanley <joel@jms.id.au>

> diff --git a/drivers/jtag/jtag-aspeed.c b/drivers/jtag/jtag-aspeed.c
> index 9cbd6da..f679041 100644
> --- a/drivers/jtag/jtag-aspeed.c
> +++ b/drivers/jtag/jtag-aspeed.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>

Oops, this is in the wrong patch.

>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <uapi/linux/jtag.h>
