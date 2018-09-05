From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 5 Sep 2018 10:11:19 -0300
Subject: [PATCH v2 3/4] media: imx-pxp: add i.MX Pixel Pipeline driver
In-Reply-To: <20180905100018.27556-4-p.zabel@pengutronix.de>
References: <20180905100018.27556-1-p.zabel@pengutronix.de>
 <20180905100018.27556-4-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5D20FG0=5FLJ3XMBd=vam9h3GMgkUKEfiPCbUKNrTw2Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Wed, Sep 5, 2018 at 7:00 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> index 000000000000..2f90c692f3fe
> --- /dev/null
> +++ b/drivers/media/platform/imx-pxp.c
> @@ -0,0 +1,1774 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

The recommended SPDX format in this case is:

// SPDX-License-Identifier: GPL-2.0+

as per Documentation/process/license-rules.rst

Thanks
