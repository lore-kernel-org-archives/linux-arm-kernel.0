From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 May 2013 21:15:28 +0200
Subject: [PATCH 3/3] ARM: dts: Add MC13783 support for i.MX27 Phytec
 PCM038 module
In-Reply-To: <1367422837.138582176@f94.mail.ru>
References: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
 <1367405219-19078-3-git-send-email-shc_work@mail.ru>
 <20130501153609.GA31135@pengutronix.de>
 <1367422837.138582176@f94.mail.ru>
Message-ID: <20130501191528.GB31135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 07:40:37PM +0400, Alexander Shiyan wrote:
> > On Wed, May 01, 2013 at 02:46:59PM +0400, Alexander Shiyan wrote:
> > > Added MC13783 node to imx27-phytec-phycore DT file.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  arch/arm/boot/dts/imx27-phytec-phycore.dts | 92 ++++++++++++++++++++++++++++++
> > >  1 file changed, 92 insertions(+)
> > 
> > You can merge this with the previous patch.
> 
> Part 2 just adds a SPI host for the target. Is this merge is really necessary?

The SPI host does nothing without devices registered on it, so why not
make 2/3 and 3/3 a single patch?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
