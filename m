From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jun 2011 13:30:07 +0200
Subject: [PATCH 2/3] ARM mxs: adjust pwm resources to what the driver
	expects
In-Reply-To: <1309430517-23821-3-git-send-email-s.hauer@pengutronix.de>
References: <1309430517-23821-1-git-send-email-s.hauer@pengutronix.de>
	<1309430517-23821-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <201106301330.07645.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 June 2011, Sascha Hauer wrote:
> The PWMs on i.MX23/28 have almost seperated register spaces
> but share a common enable register. To reflect this register
> a parent device to the PWMs which handles the enable register.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
