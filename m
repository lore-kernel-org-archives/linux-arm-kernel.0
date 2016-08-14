From: ayaka@soulik.info (Randy Li)
Date: Sun, 14 Aug 2016 19:27:22 +0800
Subject: [PATCH 0/2] ARM: dts: rockchip: correct the regulators in firefly
 reload
In-Reply-To: <522097f6-8b5c-ee6d-c1b1-a63840228a0e@rock-chips.com>
References: <522097f6-8b5c-ee6d-c1b1-a63840228a0e@rock-chips.com>
Message-ID: <1471174044-26003-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I double check the regulators settings in dts after the sdcard issue,
I found I didn't make them match the hardware of firefly reload board.

Randy Li (2):
  ARM: dts: rockchip: remove excess sd properties for firefly reload
  ARM: dts: rockchip: add missing regulators for firefly reload board

 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 29 +--------
 arch/arm/boot/dts/rk3288-firefly-reload.dts       | 71 +++++++++++++++++++----
 2 files changed, 60 insertions(+), 40 deletions(-)

-- 
2.7.4
