From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 11 Apr 2016 11:01:56 +0800
Subject: [PATCH v3 0/2] Add Hisilicon Random Number Generator(RNG) support
Message-ID: <1460343718-2722-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
- Remove unused RNG_RELOAD_ERR.
- Add comment of seed choice in hisi_rng_init
- Add head inculde linux/random.h for get_random_bytes()

Changes since v1:
- Rename compatible name from "hisilicon,hisi-rng" to "hisilicon,rng"

Kefeng Wang (2):
  dt/bindings: Add bindings for hisilicon random number generator
  hwrng: hisi: Add support for Hisilicon SoC RNG

 Documentation/devicetree/bindings/rng/hisi-rng.txt |  12 ++
 drivers/char/hw_random/Kconfig                     |  13 +++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/hisi-rng.c                  | 125 +++++++++++++++++++++
 4 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/hisi-rng.txt
 create mode 100644 drivers/char/hw_random/hisi-rng.c

-- 
1.7.12.4
