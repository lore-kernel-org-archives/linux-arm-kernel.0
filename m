From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 23 Apr 2012 11:22:40 +0200
Subject: [PATCH 00/10] allow mxc_nand to be probed via device tree
Message-ID: <20120423092240.GA18013@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series aims to be able to probe mxc_nand devices via device tree.
Most of its patches reorganize the driver to only use cpu_is_mxYZ for
the case that the device is not probed via device tree.

I split this conversion in several patches to allow easier review. IMHO
it makes sense to keep this splitting for an eventual bisection.

This is tested on an i.MX27 based machine and works fine including
passing of partition data.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
