From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 23 Jun 2013 11:07:06 +0200
Subject: [PATCH v2 3/5] ARM: dts: imx27: Add 1-wire
In-Reply-To: <1371977674.224117544@f196.mail.ru>
References: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
 <1371977061-9891-4-git-send-email-mpa@pengutronix.de>
 <1371977674.224117544@f196.mail.ru>
Message-ID: <20130623090706.GC13104@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 12:54:34PM +0400, Alexander Shiyan wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> ...
> > +			owire: owire at 10009000 {
> > +				compatible = "fsl,imx27-owire", "fsl,imx21-owire";
> > +				reg = <0x10009000 0x1000>;
> > +				clocks = <&clks 35>;
> > +				clock-names = "ipg";
> 
> Clock name can be discarded here.

Thanks, I fixed both, owire and memory offset.

Regards,

Markus

> 
> > +				status = "disabled";
> > +			};
> > +
> 
> 
> ---

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
