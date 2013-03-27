From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Mar 2013 12:22:30 +0100
Subject: [PATCH 0/2] ARM: imx35 clk bugfixes
Message-ID: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Two bugfixes which enable needed clocks. In both cases the
first boot worked because the clocks were enabled by default
after powerup. After disabling the unused clocks in the boot
process, some parts were not working anymore and device
init for example after a reboot did not work.

Regards,

Markus
