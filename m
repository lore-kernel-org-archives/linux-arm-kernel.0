From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  5 Mar 2014 17:58:25 +0800
Subject: [PATCH v4 0/4] PWM: add and enable CSR SiRFSoC PWM driver
Message-ID: <1394013506-6246-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Barry Song (3):
  pwm: sirf: add dt-binding document
  ARM: dts: sirf: fix the pwm-cells and clocks for pwm
  ARM: prima2_defconfig: enable PWM and sirf PWM driver

Huayi Li (1):
  pwm: add CSR SiRFSoC PWM driver

 Documentation/devicetree/bindings/pwm/pwm-sirf.txt |   23 ++
 arch/arm/boot/dts/atlas6.dtsi                      |    5 +-
 arch/arm/boot/dts/prima2.dtsi                      |    6 +-
 arch/arm/configs/prima2_defconfig                  |    2 +
 drivers/pwm/Kconfig                                |    9 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-sirf.c                             |  329 ++++++++++++++++++++
 7 files changed, 371 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt
 create mode 100644 drivers/pwm/pwm-sirf.c

-- 
1.7.5.4
