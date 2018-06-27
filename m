From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Jun 2018 11:31:22 -0300
Subject: [PATCH] ARM: dts: imx6sll-evk: enable usdhc3 slot
In-Reply-To: <1530088605-9264-1-git-send-email-Anson.Huang@nxp.com>
References: <1530088605-9264-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DoRUSOfV_oh242w6s_1Zs8yAy9Kf4D+WdYym5c+6nucg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Wed, Jun 27, 2018 at 5:36 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> +&usdhc3 {
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 = <&pinctrl_usdhc3>;
> +       pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +       pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +       cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> +       keep-power-in-suspend;
> +       enable-sdio-wakeup;
> +       vmmc-supply = <&reg_sd3_vmmc>;
> +       status = "okay";
> +};
> +
>  &usbotg1 {

Please keep the nodes sorted in alphabetical order.
