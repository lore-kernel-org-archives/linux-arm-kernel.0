From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 9 Feb 2015 16:07:08 -0800
Subject: [PATCH 0/2] Add support for Broadcom RNG200
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Message-ID: <1423526830-29516-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patchsets contains the Broadcom Random Number Generator
driver and device tree binding documentation.

Scott Branden (2):
  hwrng: iproc-rng200 - Add Broadcom IPROC RNG driver
  hwrng: iproc-rng200 - Add device tree bindings

 .../bindings/hwrng/brcm,iproc-rng200.txt           |  12 ++
 drivers/char/hw_random/Kconfig                     |  13 ++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/iproc-rng200.c              | 239 +++++++++++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/brcm,iproc-rng200.txt
 create mode 100644 drivers/char/hw_random/iproc-rng200.c

-- 
2.2.2
