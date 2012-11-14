From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Nov 2012 09:57:50 -0200
Subject: [PATCH 2/6] usb: chipidea: usbmisc: rename file, struct and
 functions to usbmisc_imx
In-Reply-To: <1352894137-2050-3-git-send-email-m.grzeschik@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352894137-2050-3-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <CAOMZO5Ajdp3DT1b+Mx6ufjhuCoOmZ6CEwk+TgWEj-mjd1Hub1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Wed, Nov 14, 2012 at 9:55 AM, Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
> This driver will be used for every Freescale SoC which has this misc
> memory layout to control the basic usb handling. So better name this
> driver, function and struct names in a more generic way.
>
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c   |  163 ++++++++++++++++++++++++++++++++++
>  drivers/usb/chipidea/usbmisc_imx6q.c |  163 ----------------------------------

Please use git mv / git format -M so that git can detect the file rename.

Thanks,

Fabio Estevam
