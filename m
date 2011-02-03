From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 3 Feb 2011 18:05:07 +0100
Subject: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to
	configure pendown_gpio
In-Reply-To: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20110203170507.GG6508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
> The ads7846 driver requests a gpio but does not currently
> configure it explicitly as an input. Use gpio_request_one
> to request and configure it at one shot.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>

Since the two are won't be merged

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110203/5006f063/attachment.sig>
