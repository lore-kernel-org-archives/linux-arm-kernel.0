From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Jan 2015 12:51:36 -0200
Subject: [PATCH v5 3/6] iio: adc: fsl,imx25-gcq driver
In-Reply-To: <1422108103-15052-4-git-send-email-mpa@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-4-git-send-email-mpa@pengutronix.de>
Message-ID: <CAOMZO5DdeQ+7wwytyRiTd6og2DarS9vBoMhq04gfvMfhS+UPag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Sat, Jan 24, 2015 at 12:01 PM, Markus Pargmann <mpa@pengutronix.de> wrote:

> +       priv->irq = platform_get_irq(pdev, 0);
> +       if (priv->irq <= 0) {

This should be: if (priv->irq < 0) {
