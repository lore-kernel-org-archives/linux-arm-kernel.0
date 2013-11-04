From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Nov 2013 14:06:08 +0100
Subject: [PATCH] pinctrl: imx50: add pinctrl support code for the IMX50 SoC
In-Reply-To: <CACRpkdb5U2xBBVerbspTnW5=61kwx0+mvLGZF=VmdOKrN3QhHg@mail.gmail.com>
References: <1383023635-30640-1-git-send-email-gerg@uclinux.org>
 <CACRpkdb5U2xBBVerbspTnW5=61kwx0+mvLGZF=VmdOKrN3QhHg@mail.gmail.com>
Message-ID: <20131104130608.GU24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 01:14:32PM +0100, Linus Walleij wrote:
> On Tue, Oct 29, 2013 at 6:13 AM,  <gerg@uclinux.org> wrote:
> 
> > From: Greg Ungerer <gerg@uclinux.org>
> >
> > Add code to support the specific pin arrangements of the Freescale IMX50 SoC.
> >
> > Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> 
> Can I get some maintainer to review this for the next cycle?
> 
> BTW: how many i.MX:es does remain? Have we not covered
> them all soon?

We have three different iomux ips. I once ordered them by an arbitrary
version number. We have

iomux-v1: i.MX1, i.MX21, i.MX27
iomux-v2: i.MX31
iomux-v3: i.MX25, i.MX35, i.MX50 i.MX51, i.MX53, i.MX6

I think it's quite unlikely that someone writes a iomux-v2 driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
