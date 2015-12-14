From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Dec 2015 09:40:24 +0000
Subject: [PATCH 0/4] nvmem: fixes for v4.5
Message-ID: <1450086024-18297-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here are couple of nvmem fixes on the mailing list which are good to go in
v4.5. Could you please take them thru the char-misc tree.

Thanks,
srini

Caesar Wang (2):
  nvmem: sunxi: trivial: fix code style
  nvmem: rockchip: trivial: Make the driver more readability

Srinivas Kandagatla (1):
  nvmem: core: return error for non word aligned access

Stephen Boyd (1):
  nvmem: qfprom: Specify LE device endianness

 drivers/nvmem/core.c           |  6 +++
 drivers/nvmem/qfprom.c         |  1 +
 drivers/nvmem/rockchip-efuse.c | 90 ++++++++++++++++++++----------------------
 drivers/nvmem/sunxi_sid.c      |  9 ++---
 4 files changed, 52 insertions(+), 54 deletions(-)

-- 
1.9.1
