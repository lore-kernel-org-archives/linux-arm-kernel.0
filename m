From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 5 May 2018 12:17:39 -0300
Subject: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
In-Reply-To: <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
 <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5A7bf1qcHrWjM1mr31Nkz+oDJ=fQo3rjksp1YY-HhPM9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

>  &iomuxc {
> +       pinctrl_egalax_int: egalax-intgrp {
> +               fsl,pins = <
> +                       MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x80000000

Please avoid using 0x80000000 and use the real IOMUX value instead.
