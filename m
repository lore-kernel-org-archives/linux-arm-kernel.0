From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Jan 2014 08:13:15 -0200
Subject: imx6dl/imx6q fec rmii mode with external ref_clk
In-Reply-To: <20140115094551.GA26117@frolo.macqel>
References: <20140114153012.GA22550@frolo.macqel>
 <20140115073536.GD1914@S2101-09.ap.freescale.net>
 <20140115094551.GA26117@frolo.macqel>
Message-ID: <CAOMZO5AhTLN+aCRH0FOVFO3uoZqe=2DpSiAHO2NCCTd=yJSyHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 7:45 AM, Philippe De Muyter <phdm@macq.eu> wrote:

> Here are my patches (I have called my board imx6dl-p6-2094):
> Do I need to replace the hex value after MX6QDL_PAD_GPIO_16__ENET_REF_CLK
> by something else ?

hummingboard uses:

MX6QDL_PAD_GPIO_16__ENET_REF_CLK    0xc0000000

Check arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi in linux-next.

Regards,

Fabio Estevam
