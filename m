From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  1 Jul 2015 13:36:00 +0100
Subject: [PATCH 0/3] arm/arm64: vexpress: DT updates for v4.2
Message-ID: <1435754163-17929-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC guys,

Here are couple of fixes for adding missing nodes(CCI and A7 PMUs) in
TC2 device tree. The third patch is addition of support for FPGA based
dual core A53 SMM  platform. All the patches are posted on the list
already, just putting them together. Let me know if you prefer a pull
request.

Regards,
Sudeep

Kristina Martsenko (1):
  arm64: dts: add device tree for ARM SMM-A53x2 on LogicTile Express
    20MG

Mark Rutland (1):
  arm: dts: vexpress: describe all PMUs in TC2 dts

Sudeep Holla (1):
  arm: dts: vexpress: add missing CCI PMU device node to TC2

 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  25 ++-
 arch/arm64/boot/dts/arm/Makefile                   |   1 +
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      | 191 +++++++++++++++++++++
 4 files changed, 216 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts

-- 
1.9.1
