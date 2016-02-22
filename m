From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 22 Feb 2016 11:22:41 +0000
Subject: [PATCH 0/3] nvmem: fixes for v4.6
Message-ID: <1456140161-6851-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here are couple of nvmem fixes on the mailing list which are good to go in
v4.6. Could you please take them thru the char-misc tree.

Thanks,
srini

Andrew-CT Chen (1):
  nvmem: mediatek: Fix later provider initialization

Axel Lin (1):
  nvmem: imx-ocotp: Fix return value of imx_ocotp_read

Richard Weinberger (1):
  nvmem: Fix dependencies for !HAS_IOMEM archs

 drivers/nvmem/Kconfig     |  4 ++++
 drivers/nvmem/imx-ocotp.c |  2 +-
 drivers/nvmem/mtk-efuse.c | 23 ++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
1.9.1
