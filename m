From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 15 Apr 2014 10:07:23 +0200
Subject: [PATCH 0/2] ARM: berlin: add GPIO support for the BG2Q
Message-ID: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add the support for the GPIOs of the Berlin BG2Q. We use the
newly integrated dwapb GPIO driver here.

This applies on top of Alexandre's BG2Q symbol introduction[1] and the dwapb
gpio patch fixing IRQ initialization[2].

[1] https://patchwork.kernel.org/patch/3876141/
[2] https://lkml.org/lkml/2014/4/7/96

Antoine T?nart (2):
  ARM: berlin: add the LIBGPIO as a dependency for the BG2Q
  ARM: dts: berlin: add GPIO nodes for the BG2Q

 arch/arm/boot/dts/berlin2q.dtsi | 102 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-berlin/Kconfig    |   1 +
 2 files changed, 103 insertions(+)

-- 
1.8.3.2
