From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Sep 2012 09:09:48 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120913164120.cde08ac1517e641386b147d8@canb.auug.org.au>
References: <20120913164120.cde08ac1517e641386b147d8@canb.auug.org.au>
Message-ID: <20120913070948.GC19497@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Sep 13, 2012 at 04:41:20PM +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/i2c/busses/i2c-omap.c between commit d9ebd04d3476 ("i2c: omap:
> switch to devm_* API") from the i2c-embedded tree and commit 07baca6f8fc2
> ("i2c/i2c-omap: add a const qualifier") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
looks correct.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
