From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon,  2 Jul 2012 11:02:59 +0200
Subject: [PATCH v2 0/2] arm: imx/mxs: enable flexcan driver
Message-ID: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

as the flexcan driver has DT binding for some time now. This patch makes
the flexcan driver available in the can drivers menu if a SOC with flexcan
is enabled.

Changes since v2:
- improve commit message as requested by Shawn

regards, Marc
