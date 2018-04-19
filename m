From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Apr 2018 18:23:24 +0200
Subject: [PATCH 53/61] tty: serial: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
Message-ID: <20180419162324.f46tsdomp4vi67cb@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Thu, Apr 19, 2018 at 04:06:23PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/tty/serial/imx.c              | 18 ++++++------------

for serial/imx.c:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks Wolfram for going through this
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
