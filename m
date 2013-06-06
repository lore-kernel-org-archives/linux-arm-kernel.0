From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 6 Jun 2013 10:20:20 -0300
Subject: [PATCH v2] ARM: imx: Remove mxc specific ulpi access ops
In-Reply-To: <1370522517-2873-1-git-send-email-mpa@pengutronix.de>
References: <1370522517-2873-1-git-send-email-mpa@pengutronix.de>
Message-ID: <CAOMZO5AsLgWUX==n1pqn8jFu=krJx8L6q7GRNyP17aBQJsunuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Thu, Jun 6, 2013 at 9:41 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> There are ulpi access ops implemented in drivers/usb/phy/phy-ulpi.c.
> mxc access ops implement the same access operations within mach-imx. This
> patch removes the mxc ulpi file and uses phy-ulpi instead for
> imx_otg_ulpi_create.
>
> phy-ulpi successfully tested with i.MX27 Phytec phyCARD-S (pca100).
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Unrelated to this patch, but just out of curiosity: have you also try
to use the chipidea driver with mx27?

Regards,

Fabio Estevam
