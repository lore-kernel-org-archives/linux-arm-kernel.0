From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 17 Apr 2015 20:20:24 -0300
Subject: [PATCH v3 09/10] arm: dts: add imx7d-sdb support
In-Reply-To: <1429306135-24695-10-git-send-email-Frank.Li@freescale.com>
References: <1429306135-24695-1-git-send-email-Frank.Li@freescale.com>
 <1429306135-24695-10-git-send-email-Frank.Li@freescale.com>
Message-ID: <CAOMZO5B9Ckc_YQpn4wrLLbEU-jahuZ4POBw2jtWi7GayLKp=zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 6:28 PM,  <Frank.Li@freescale.com> wrote:

> +               pinctrl_max17135: max17135grp-1 {
> +                       fsl,pins = <
> +                               MX7D_PAD_EPDC_PWR_STAT__GPIO2_IO31      0x80000000  /* pwrgood */
> +                               MX7D_PAD_I2C4_SCL__GPIO4_IO14           0x80000000  /* vcom_ctrl */
> +                               MX7D_PAD_EPDC_SDCE3__GPIO2_IO23         0x80000000  /* wakeup */
> +                               MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30       0x80000000  /* v3p3 */
> +                               MX7D_PAD_EPDC_SDCE2__GPIO2_IO22         0x80000000  /* pwr int */

As I mentioned earlier, no 0x80000000 settings, please. Better use the
real values instead.
