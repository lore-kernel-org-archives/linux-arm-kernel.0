From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  9 Jun 2017 15:59:31 +0800
Subject: [PATCH v1 0/2] Patches to add support spdif for rk322x
Message-ID: <1496995173-63532-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches to add support spdif for rk322x socs.


Sugar Zhang (2):
  ASoC: rockchip: add bindings for spdif controller
  ARM: dts: rk322x: add spdif node

 .../devicetree/bindings/sound/rockchip-spdif.txt     |  2 ++
 arch/arm/boot/dts/rk322x.dtsi                        | 20 ++++++++++++++++++++
 sound/soc/rockchip/rockchip_spdif.c                  |  4 ++++
 3 files changed, 26 insertions(+)

-- 
1.9.1
