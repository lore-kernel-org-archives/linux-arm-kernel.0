From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 8 Mar 2015 17:04:54 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx6: factor out pinmux for edm1 module
In-Reply-To: <1425831960-10259-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1425831960-10259-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <CAOMZO5BF=a8t4ayhLm2G332jDVqmFiGeMSwb4WHonv-YboZryA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 8, 2015 at 1:25 PM, Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
> Thw Wandboard is using the EDM1-CF-IMX6 module which is
> defined under the edm standard.
>
> http://www.edm-standard.org/
>
> As this module is used on more boards this patch moves the default
> pinmux settings into the special file imx6qdl-edm1.dtsi.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> - fixed the alphabetical order of the nodes
> - moved MX6QDL_PAD_GPIO_16__ENET_REF_CLK to the board hogpins

Adding Alfonso in case he can help testing v2.

Regards,

Fabio Estevam
