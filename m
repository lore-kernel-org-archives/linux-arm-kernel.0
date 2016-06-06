From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  6 Jun 2016 16:59:22 +0100
Subject: [PATCH 0/3] arm64: dts: juno: add coresight support
Message-ID: <1465228765-14038-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for coresight debug subsystem based on similar
support on Vexpress TC2 platform by Mathieu Poirier. It also contains
a workaround required to prevent bus stall quite early in the boot.
It uses power domain provided by SCPI, so it depends on scpi patches[1].

Regards,
Sudeep

[1] http://marc.info/?l=linux-kernel&m=146522850003483&w=2

Sudeep Holla (3):
  arm64: dts: juno: add coresight support
  arm64: dts: juno: add arm,primecell-periphid override
  arm64: dts: juno: add SCPI power domains for device power management

 arch/arm64/boot/dts/arm/juno-base.dtsi | 327 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    |  30 +++
 arch/arm64/boot/dts/arm/juno-r2.dts    |  30 +++
 arch/arm64/boot/dts/arm/juno.dts       |  30 +++
 4 files changed, 417 insertions(+)

--
2.7.4
