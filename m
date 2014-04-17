From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu, 17 Apr 2014 10:45:27 +0200
Subject: [PATCH 0/2] Add GPIO nodes for Berlin BG2 and BG2CD
Message-ID: <1397724329-14154-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adding support for the Berlin BG2Q GPIOs, this series uses the
same GPIO dwapb driver to support the Berlin BG2 and BG2CD GPIOs.

Applies on top of Sebastian's for-next branch[1].

[1] https://github.com/shesselba/linux-berlin/commits/berlin/for-next

Antoine T?nart (2):
  ARM: dts: berlin: add the BG2 GPIO nodes
  ARM: dts: berlin: add the BG2CD GPIO nodes

 arch/arm/boot/dts/berlin2.dtsi   | 105 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/berlin2cd.dtsi | 102 +++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

-- 
1.8.3.2
