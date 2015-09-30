From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 13:31:38 +0100
Subject: [PATCH 0/4] nvmem: fixes for next rc
Message-ID: <1443616298-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here are couple of nvmem fixes on the mailing list which are good to go in
next rc. Could you please take them thru the char-misc tree.

Thanks,
srini

Axel Lin (2):
  nvmem: core: Handle shift bits in-place if cell->nbits is non-zero
  nvmem: core: Fix memory leak in nvmem_cell_write

Maxime Ripard (1):
  nvmem: sunxi: Check for memory allocation failure

ZhengShunQian (1):
  nvmem: core: fix the out-of-range leak in read/write()

 drivers/nvmem/core.c      |  8 ++++----
 drivers/nvmem/sunxi_sid.c | 11 ++++++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

-- 
1.9.1
