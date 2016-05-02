From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon,  2 May 2016 16:22:56 +0100
Subject: [PATCH v2 0/2] nvmem: remove regmap dependency
Message-ID: <1462202578-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, 

This is v2 patchset for the leftover 2 patches on top of char-misc tree.

Changes since v1:
 - rebased mtk-efuse on top of char-misc
 - addressed concerns raised by Stefan Wahren.

Thanks,
srini

Srinivas Kandagatla (2):
  nvmem: mtk-efuse: remove nvmem regmap dependency
  nvmem: mxs-ocotp: remove nvmem regmap dependency

 drivers/nvmem/Kconfig     |  1 -
 drivers/nvmem/mtk-efuse.c | 47 ++++++++++++++++++---------
 drivers/nvmem/mxs-ocotp.c | 81 +++++++++++++----------------------------------
 3 files changed, 54 insertions(+), 75 deletions(-)

-- 
2.5.0
