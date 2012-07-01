From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sun,  1 Jul 2012 22:46:03 +0200
Subject: [PATCH 0/2] arm: imx/mxs: enable flexcan driver
Message-ID: <1341175565-13218-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

as the flexcan driver has DT binding for some time now. This patch makes
the flexcan driver available in the can drivers menu if a SOC with flexcan
is enabled.

These patches apply to 3.5-rc5.

regards, Marc
