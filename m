From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 30 Jan 2015 08:27:39 +0100
Subject: [PATCH v5 3/6] iio: adc: fsl,imx25-gcq driver
In-Reply-To: <CAOMZO5DdeQ+7wwytyRiTd6og2DarS9vBoMhq04gfvMfhS+UPag@mail.gmail.com>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-4-git-send-email-mpa@pengutronix.de>
 <CAOMZO5DdeQ+7wwytyRiTd6og2DarS9vBoMhq04gfvMfhS+UPag@mail.gmail.com>
Message-ID: <20150130072739.GB16879@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Jan 29, 2015 at 12:51:36PM -0200, Fabio Estevam wrote:
> Hi Markus,
> 
> On Sat, Jan 24, 2015 at 12:01 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > +       priv->irq = platform_get_irq(pdev, 0);
> > +       if (priv->irq <= 0) {
> 
> This should be: if (priv->irq < 0) {

Thanks, fixed in both drivers.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/ad2b7ac8/attachment.sig>
