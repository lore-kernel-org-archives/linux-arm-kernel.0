From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 30 Jul 2015 08:28:29 +0200
Subject: [PATCH] soc: mediatek: Fix SCPSYS compilation
In-Reply-To: <1438192988-17115-1-git-send-email-matthias.bgg@gmail.com>
References: <1438192988-17115-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20150730062829.GL18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 08:03:08PM +0200, Matthias Brugger wrote:
> SCPSYS driver misses the module.h include which makes it fail
> when compiling with allmodconf.
> 
> This patch fixes this.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
