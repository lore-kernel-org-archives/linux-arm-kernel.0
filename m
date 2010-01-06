From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Jan 2010 17:59:33 +0100
Subject: [PATCH 1/2] Remove unneeded __init from s3c24xx_ts_set_platdata
In-Reply-To: <20100106094146.17269.6955.stgit@localhost>
References: <20100106094146.17269.6955.stgit@localhost>
Message-ID: <20100106165933.GA26395@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 06, 2010 at 04:41:47AM -0500, Nelson Castillo wrote:
> Remove unneeded __init in function definition.
you should only remove '__init's if they are wrong.  And if these are
wrong, you should point out why.
 
Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
