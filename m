From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 5 Jun 2016 16:14:38 -0300
Subject: [PATCH v2 2/4] ARM: dts: imx6q: extend support for the cm-fx6
In-Reply-To: <90e7dea7dee342cf82ccedcd463a60fc@rwthex-s1-b.rwth-ad.de>
References: <20160605182657.1706-1-christopher.spinrath@rwth-aachen.de>
 <90e7dea7dee342cf82ccedcd463a60fc@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5DX9W4MV3gTVJdxLZ4pFy98MME9FR+qjg8VAh-1-SVK6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 5, 2016 at 3:26 PM,  <christopher.spinrath@rwth-aachen.de> wrote:

> +&pcie {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pcie>;
> +       reset-gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;

I suppose this should be active low, right?

With this fixed:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
