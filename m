From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 27 Jun 2013 09:22:08 +0200
Subject: [PATCH 0/3] ARM: imx: flexcan: convert transceiver switching to DT
Message-ID: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series converts the flexcan driver from using a callback function
(configured via platform data), to switch the transceiver on and off, to a
standard regulator. As there are no in-tree users of the platform data, it's
finally removed.

If there are no objections I'd like to upstream this via can-next and David
Miller's net-next. As these patches are touching arch/arm/mach-imx, I don't
want to continue without some Acked-bys.

regards,
Marc
