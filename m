From: cphealy@gmail.com (Chris Healy)
Date: Sat, 11 Feb 2017 10:37:00 -0800
Subject: [PATCH v2] ARM: imx6: add ZII RDU2 boards
In-Reply-To: <20170210153928.30588-1-l.stach@pengutronix.de>
References: <20170210153928.30588-1-l.stach@pengutronix.de>
Message-ID: <CAFXsbZqc=XTDrE4mZ8+T5fVM-rUszx3Bp9N-EZV0VaZQaVzWYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +#include <imx6qp.dtsi>
> +#include <imx6qdl-zii-rdu2.dtsi>
> +
> +/ {
> +       model = "ZII RDU2+ Board";
> +       compatible = "zii,imx6qp-zii-rdu2", "fsl,imx6qp";
> +};
> --
> 2.11.0
>

Tested-by: Chris Healy <cphealy@gmail.com>
