From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 29 Mar 2013 16:20:08 +0100
Subject: [PATCH v2 0/2] ARM: imx35 clock bugfixes
Message-ID: <1364570410-32755-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Two bugfixes which enable needed clocks. In both cases the
first boot worked because the clocks were enabled by default
after powerup. After disabling the unused clocks in the boot
process, some parts were not working anymore and device
init for example after a reboot did not work.

Changes in v2:
- admux clock removed from imx-ssi and attached to imx-audmux by
  registration of admux clock as "audmux"

Regards,

Markus
