From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Mar 2013 16:02:29 +0100
Subject: [PATCH 0/2] mmc: mxs-mmc: add cd-inverted and non-removeable
Message-ID: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch add support for the cd-inverted and non-removeable property (as
defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver. Tested on a
custom imx28 board.

This series applies to Chris Ball's cjb/mmc-next branch.

regards,
Marc Kleine-Budde
