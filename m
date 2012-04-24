From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 24 Apr 2012 17:48:16 +0200
Subject: [PATCH v2 0/2] minor cleanups on imx
Message-ID: <1335282498-15896-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this series applies to v3.4-rc4, it adds a missing static to struct sys_timer
in some imx platforms and adds some missing IMX_HAVE_PLATFORM to MACH_MX35_3DS
in Kconfig.

regards, Marc
