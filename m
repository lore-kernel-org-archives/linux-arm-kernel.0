From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Nov 2014 16:57:11 +0100
Subject: [PATCH v2 2/5] i2c: davinci: query STP always when NACK is
 received
In-Reply-To: <1417010393-30598-3-git-send-email-grygorii.strashko@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20141126155711.GL4431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I don't understand your use of "query" in the subject and later in the
commit log. Do you mean "send"?

On Wed, Nov 26, 2014 at 03:59:50PM +0200, Grygorii Strashko wrote:
> According to I2C specification the NACK should be handled as folows:
s/folows/follows/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
