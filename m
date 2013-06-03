From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Jun 2013 10:32:44 +0200
Subject: [PATCH v2] clk: implement clk_unregister
In-Reply-To: <1370247855-3547-1-git-send-email-jiada_wang@mentor.com>
References: <1370247855-3547-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <20130603083244.GA23140@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jun 03, 2013 at 05:24:15PM +0900, Jiada Wang wrote:
> Currently clk_unregister is unimplemented, it is required in case
> sub modules want actually remove clk device registered by clk_register.
> This patch adds the implementation of clk_unregiser.
s/unregiser/unregister/

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
