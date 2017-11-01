From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  1 Nov 2017 16:20:04 -0700
Subject: [PATCH 0/2] hwrng: iproc-rng200: Add support for BCM7278
Message-ID: <20171101232006.3943-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the RNG200 block found on the BCM7278 SoC.
This requires us to update the compatible string (and associated binding
document) as well as the Kconfig option to make that driver selectable with
ARCH_BRCMSTB gating the enabling of such SoCs.

Thank you

Florian Fainelli (2):
  dt-bindings: rng: Document BCM7278 RNG200 compatible
  hwrng: iproc-rng200: Add support for BCM7278

 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt | 4 +++-
 drivers/char/hw_random/Kconfig                              | 6 +++---
 drivers/char/hw_random/iproc-rng200.c                       | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.9.3
