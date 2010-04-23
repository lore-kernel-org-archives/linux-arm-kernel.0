From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 23 Apr 2010 23:25:44 +0200
Subject: [PATCH] pxa32xx_nand: add support for partition table parsing
Message-ID: <1272057944-19380-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa32xx_nand driver doesn't support partition tables from the
command line. This patch adds support for it.

Please review and consider to apply.

cheers, Marc
