From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 28 Jul 2013 12:22:15 +0200
Subject: [RFC 4/8] pinctrl: imx: Support imx21 register format
In-Reply-To: <20130728083436.GI2737@pengutronix.de>
References: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
 <1374938808-27316-5-git-send-email-mpa@pengutronix.de>
 <20130728083436.GI2737@pengutronix.de>
Message-ID: <20130728102215.GH16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Sun, Jul 28, 2013 at 10:34:36AM +0200, Sascha Hauer wrote:
> Hi Markus,
> 
> On Sat, Jul 27, 2013 at 05:26:44PM +0200, Markus Pargmann wrote:
> > The imx pinctrl core driver does not support the imx21 register format
> > yet. This patch adds support for the strange iomux control registers of
> > imx21 and imx27. Next to a slightly different DT parse function.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/pinctrl/pinctrl-imx.c | 264 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 250 insertions(+), 14 deletions(-)
> 
> Is it really worth sharing the i.MX1/21/27 support with the imx driver?
> It seems most of the code is rewritten. I just tried and removed all
> lines from pinctrl-imx.c you don't use. There's not much left to share.

Yes it's really not that much to share. I will move it to a seperate
file for imx1/21/27.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
