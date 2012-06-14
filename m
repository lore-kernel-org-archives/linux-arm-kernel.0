From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 14 Jun 2012 11:28:52 +0100
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1339669732.6598.7.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-13 at 23:12 +0200, Wolfram Sang wrote:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/i2c/busses/i2c-versatile.c          |    1 -
>  drivers/i2c/i2c-core.c                      |    3 +++

For what it's worth

Tested-by: Pawel Moll <pawel.moll@arm.com>

on Versatile Express.

Regards

Pawe?
