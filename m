From: ayaka@soulik.info (Randy Li)
Date: Thu, 18 Aug 2016 01:03:09 +0800
Subject: [PATCH 0/2 v2] ARM: dts: rockchip: correct the regulators in firefly
 reload
In-Reply-To: <19126716.OZv44ZHtAK@diego>
References: <19126716.OZv44ZHtAK@diego>
Message-ID: <1471453391-10267-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last version forget to check the regulators in PMU. This
verison would fix them. I have remove regualtor-always-on as much
as possible.

Randy Li (2):
  ARM: dts: rockchip: remove excess sd properties for firefly reload
  ARM: dts: rockchip: add missing regulators for firefly reload board

 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 49 ++++------------
 arch/arm/boot/dts/rk3288-firefly-reload.dts       | 69 +++++++++++++++++++----
 2 files changed, 68 insertions(+), 50 deletions(-)

-- 
2.7.4
