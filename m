From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Dec 2017 13:10:06 -0200
Subject: [PATCH v1 1/6] ARM: dts: imx7d-sbc-iot: add initial iot gateway
 dts
In-Reply-To: <20171205222707.11302-2-tyler@opensourcefoundries.com>
References: <20171205222707.11302-1-tyler@opensourcefoundries.com>
 <20171205222707.11302-2-tyler@opensourcefoundries.com>
Message-ID: <CAOMZO5BW50xcqwjCuEs045VySDs5TmS++1Wj2SnV0Die1N5B_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 8:27 PM,  <tyler@opensourcefoundries.com> wrote:

> +&usdhc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usdhc1>;
> +       cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +       wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
> +       enable-sdio-wakeup;

This is a deprecated property.

Please use wakeup-source as stated in
Documentation/devicetree/bindings/mmc/mmc.txt
