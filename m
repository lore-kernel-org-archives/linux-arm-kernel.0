From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 30 Apr 2014 08:57:43 +0200
Subject: [PATCH] ARM: imx: imx6q, Add i2c4 clock to the clock tree
In-Reply-To: <20140430062527.GC16727@dragon>
References: <1398693282-5286-1-git-send-email-mpa@pengutronix.de>
 <20140430062527.GC16727@dragon>
Message-ID: <20140430065743.GF15179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:25:29PM +0800, Shawn Guo wrote:
> On Mon, Apr 28, 2014 at 03:54:42PM +0200, Markus Pargmann wrote:
> > This clock was missing for imx6dl SoCs. This patch adds the missing
> > clock so we can use i2c4.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> I've queued a patch which adds the clock in a slightly different way.
> 
> https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/soc&id=95dcc2093da280e5ee440d7b418997da4d9b9c01

Thanks, I didn't notice that this clock is different for imx6dl.

Regards,

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/70db50af/attachment.sig>
