From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 17 Jan 2017 14:11:07 -0200
Subject: [PATCH] ARM: dts: udoo_neo: Add UDOO Neo USB OTG1 and OTG2 support
In-Reply-To: <1484074778-2112-1-git-send-email-breno.lima@nxp.com>
References: <1484074778-2112-1-git-send-email-breno.lima@nxp.com>
Message-ID: <CAOMZO5ANg8pJLDhSUQXa8AWhGDPafeUFCMoz-iuUs-+GUbXO_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 4:59 PM, Breno Lima <breno.lima@nxp.com> wrote:

> +&usbotg1 { /* J2 micro USB port */
> +       vbus-supply = <&reg_usb_otg1_vbus>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usb_otg1>;
> +       imx6-usb-charger-detection;

Please remove this property, as it does not exist in mainline.
