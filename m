From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Sep 2012 08:58:34 +0200
Subject: [PATCH 5/8] pwm i.MX: add devicetree support
In-Reply-To: <811985020.3713350.1346881354214.JavaMail.root@advansee.com>
References: <1346852127-25226-6-git-send-email-s.hauer@pengutronix.de>
 <811985020.3713350.1346881354214.JavaMail.root@advansee.com>
Message-ID: <20120906065834.GL26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 11:42:34PM +0200, Beno?t Th?baudeau wrote:
> 
> Since this is supposed to remove platform-based support, why don't you also
> remove the PWM stuff from arch/arm/plat-mxc and
> arch/arm/mach-imx/devices-imx*.h?

Simple answer: I was too lazy yesterday. I will include it in the next
round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
