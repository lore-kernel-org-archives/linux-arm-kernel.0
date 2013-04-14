From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 14 Apr 2013 10:42:40 +0200
Subject: [PATCH] tty/serial: add MVF uart driver support
In-Reply-To: <CAOMZO5D-uQQJAc6zAMkF9ViR0KWg4q7cPr7+pLdfyAm9gtPyTA@mail.gmail.com>
References: <1365750655-3530-1-git-send-email-b35083@freescale.com>
 <CAOMZO5D-uQQJAc6zAMkF9ViR0KWg4q7cPr7+pLdfyAm9gtPyTA@mail.gmail.com>
Message-ID: <20130414084240.GY1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 13, 2013 at 05:41:26PM -0300, Fabio Estevam wrote:
> On Fri, Apr 12, 2013 at 4:10 AM, Jingchang Lu <b35083@freescale.com> wrote:
> > It adds Freescale Vybrid Family uart driver support
> >
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > ---
> >  drivers/tty/serial/Kconfig       |   17 +
> >  drivers/tty/serial/Makefile      |    1 +
> >  drivers/tty/serial/mvf.c         | 1246 ++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/serial_core.h |    3 +
> >  4 files changed, 1267 insertions(+)
> >  create mode 100644 drivers/tty/serial/mvf.c
> 
> Would it be possible to add Vybrid support into the existing imx serial port?

That's completely different hardware.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
