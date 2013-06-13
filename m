From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:25 +0900
Subject: [GIT PULL 0/1] Renesas ARM based SoC GPIO R-Car updates for v3.11 
Message-ID: <1371106826-25313-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

This pull request is based on renesas-pinmux-for-v3.11 which you have
previously pulled. It provides the GPIO R-Car driver. I have broken this
pull-request out from a separate pull request I plan to send with further
pinmux updates as it relates specifically to DT. And I wanted to give you
the option of merging it separately.

The following changes since commit 5fcf4a3c3a5bc08bf72a50ef1332501a3c1b96bb:

  ARM: shmobile: marzen: Use RCAR_GP_PIN macro (2013-06-05 17:18:24 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-gpio-rcar-for-v3.11

for you to fetch changes up to 159f8a0209aff155af7f6fcdedd4a4484dd19c23:

  gpio-rcar: Add DT support (2013-06-12 21:48:09 +0900)

----------------------------------------------------------------
Renesas ARM based SoC GPIO R-Car updates for v3.11

DT support to GPIO R-Car driver by Laurent Pinchart.

----------------------------------------------------------------
Laurent Pinchart (1):
      gpio-rcar: Add DT support

 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt | 52 +++++++++++++++++
 drivers/gpio/gpio-rcar.c                           | 66 ++++++++++++++++++----
 2 files changed, 108 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
