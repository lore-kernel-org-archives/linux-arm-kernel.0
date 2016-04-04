From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Apr 2016 08:05:58 +0200
Subject: [PATCH 1/7] ARM: dts: armv7-m: add unit name to
 interrupt-controller
In-Reply-To: <1459290646-3592-2-git-send-email-manabian@gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
 <1459290646-3592-2-git-send-email-manabian@gmail.com>
Message-ID: <20160404060558.GY6191@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joachim,

On Wed, Mar 30, 2016 at 12:30:40AM +0200, Joachim Eastwood wrote:
> Add unit name to nvic to remove the following warning:
>  Warning (unit_address_vs_reg): Node /nv-interrupt-controller has a reg
> 				or ranges property, but no unit name
> 
> Also correct the node name to 'interrupt-controller' while changing the
> line.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Looks right,

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
