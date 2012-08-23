From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 13:41:56 +0800
Subject: [PATCH v2 0/3] ARM: PRIMA2: some patches prepared to support new SiRF
 SoCs
Message-ID: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we will support SiRFmarco and SiRFpolo SMP SoCs, this series is making
mach-prima2 common for all of them.

Barry Song (3):
  ARM: PRIMA2: use DT_MACHINE_START and convert to generic board
  ARM: PRIMA2: adjust Kconfig to support select SoC features
  ARM: SIRF: make sirf irqchip driver optional since new SoCs will have
    GIC

 arch/arm/Kconfig                            |   10 +++++-----
 arch/arm/configs/prima2_defconfig           |    7 +++----
 arch/arm/mach-prima2/Kconfig                |   19 +++++++++++++++++++
 arch/arm/mach-prima2/Makefile               |    4 ++--
 arch/arm/mach-prima2/{prima2.c => common.c} |   11 ++++++-----
 arch/arm/mach-prima2/irq.c                  |    2 +-
 6 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-prima2/Kconfig
 rename arch/arm/mach-prima2/{prima2.c => common.c} (81%)



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
