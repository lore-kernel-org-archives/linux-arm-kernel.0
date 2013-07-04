From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 4 Jul 2013 15:54:52 +0800
Subject: [PATCH 0/5] a bundle of minor fixes for CSR SiRF pinctrl drivers
Message-ID: <1372924492-5477-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
this patchset is againest for-next branch of your tree. i guess there will
be no conflict in 3.11-rc.

Barry Song (2):
  arm/dts: sirf: fix the pingroup name mismatch between drivers and dts
  pinctrl: sirf: add freeze and restore entries for hibernation support

Qipan Li (2):
  pinctrl: sirf: fix the pin number and mux bit for usp0
  pinctrl: sirf: add usp0_uart_nostreamctrl pin group for usp-uart
    without flowctrl

Rongjun Ying (1):
  pinctrl: sirf: fix the checkpatch issue about indentation

 arch/arm/boot/dts/atlas6.dtsi         | 22 ++++++++++++++--------
 arch/arm/boot/dts/prima2.dtsi         | 16 ++++++++--------
 drivers/pinctrl/sirf/pinctrl-atlas6.c | 24 ++++++++++++++++++++++--
 drivers/pinctrl/sirf/pinctrl-sirf.c   |  8 +++++---
 4 files changed, 49 insertions(+), 21 deletions(-)

-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
