From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 Mar 2018 12:35:52 -0300
Subject: [PATCH v4 2/2] ARM: dts: imx: Add basic dts support for imx6sll
 EVK board
In-Reply-To: <1520503424-22985-2-git-send-email-ping.bai@nxp.com>
References: <1520503424-22985-1-git-send-email-ping.bai@nxp.com>
 <1520503424-22985-2-git-send-email-ping.bai@nxp.com>
Message-ID: <CAOMZO5AgPAgUZfd3NWa5QvyF3DcmeB06pms16aZ34sk6894TWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 8, 2018 at 7:03 AM, Bai Ping <ping.bai@nxp.com> wrote:

> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog0>, <&pinctrl_hog1>;
> +
> +       pinctrl_hog0: hog0grp {
> +               pinmux = <
> +                       MX6SLL_PAD_KEY_ROW7__GPIO4_IO07
> +                       MX6SLL_PAD_GPIO4_IO22__GPIO4_IO22
> +                       MX6SLL_PAD_KEY_COL3__GPIO3_IO30
> +                       MX6SLL_PAD_KEY_COL4__GPIO4_IO00
> +                       MX6SLL_PAD_KEY_COL5__GPIO4_IO02
> +               >;
> +               slew-rate = <0x1>;
> +               drive-strength = <0x3>;
> +               fsl,pin-speed = <0x1>;
> +               bias-pull-up = <0x1>;
> +               input-schmitt-enable;
> +       };

Please use the old style for pinctrl.
