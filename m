From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Sep 2016 16:09:38 +0200
Subject: [PATCH] serial: imx: Fix DCD reading
In-Reply-To: <20160926135531.31888-1-s.hauer@pengutronix.de>
References: <20160926135531.31888-1-s.hauer@pengutronix.de>
Message-ID: <20160926140938.ikjatvprk3t4lsed@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

On Mon, Sep 26, 2016 at 03:55:31PM +0200, Sascha Hauer wrote:
> The USR2_DCDIN bit is tested for in register usr1. As the name
> suggests the usr2 register should be used instead. This fixes
> reading the Carrier detect status.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Fixes: 90ebc4838666 ("serial: imx: repair and complete handshaking")
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
