From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 24 Apr 2012 17:13:16 +0200
Subject: [PATCH 0/2] fix minor problems on mx35_3ds/mx35pdk
Message-ID: <1335280398-19769-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series applies to v3.4-rc4, it adds a missing static to the
mx35pdk_timer struct and some missing IMX_HAVE_PLATFORM to MACH_MX35_3DS
in Kconfig.

regards, Marc
