From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 7 Apr 2016 16:23:15 +0800
Subject: [PATCH v2 0/2] Add Hisilicon Random Number Generator(RNG) support
Message-ID: <1460017397-30996-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add the Hisilicon Random Number Generator(RNG) support.

Changes since v1:
- Rename compatible name from "hisilicon,hisi-rng" to "hisilicon,rng"

Kefeng Wang (2):
  dt/bindings: Add bindings for hisilicon random number generator
  hwrng: hisi: Add support for Hisilicon SoC RNG

 Documentation/devicetree/bindings/rng/hisi-rng.txt |  12 ++
 drivers/char/hw_random/Kconfig                     |  13 +++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/hisi-rng.c                  | 121 +++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/hisi-rng.txt
 create mode 100644 drivers/char/hw_random/hisi-rng.c

-- 
2.6.0.GIT
