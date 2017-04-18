From: yong.mao@mediatek.com (Yong Mao)
Date: Tue, 18 Apr 2017 18:13:08 +0800
Subject: [RESEND v2] mmc: mediatek: Support SDIO feature 
Message-ID: <1492510391-704-1-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   2 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  77 ++++++++++
 drivers/mmc/host/mtk-sd.c                        | 182 ++++++++++++++++++-----
 3 files changed, 222 insertions(+), 39 deletions(-)

-- 
1.8.1.1.dirty
