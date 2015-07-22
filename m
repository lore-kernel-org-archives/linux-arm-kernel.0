From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 22 Jul 2015 20:04:34 +0200
Subject: [PATCH] ARM: dts: i.MX35: Fix can support
In-Reply-To: <1437577290-26321-1-git-send-email-denis@eukrea.com>
References: <1437577290-26321-1-git-send-email-denis@eukrea.com>
Message-ID: <20150722180434.GA745@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jul 22, 2015 at 05:01:30PM +0200, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>

something like:

	Since commit 23147826523 ("asjksad dsajksdkljf") the can driver
	requires a dt nodes to have a second clock. Add them to imx35 to
	fix probing the flex can driver on the respective platforms.

in the changelog would be nice.

Best regards,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
