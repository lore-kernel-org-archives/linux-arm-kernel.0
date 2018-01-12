From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 12 Jan 2018 08:37:54 +0100
Subject: [PATCH] ARM: imx: Remove epit support
In-Reply-To: <1515511483-24706-1-git-send-email-fabio.estevam@nxp.com>
References: <1515511483-24706-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20180112073754.4g3xvg47htlohtye@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 01:24:43PM -0200, Fabio Estevam wrote:
> Currently there is no user of EPIT, so remove such unused code.
> 
> If someone wants to add EPIT support back, then the person needs to
> create a proper support into drivers/clocksource/ and add device
> tree support, proper bindings, etc.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
