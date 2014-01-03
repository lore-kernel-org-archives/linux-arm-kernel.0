From: 21cnbao@gmail.com (Barry Song)
Date: Fri,  3 Jan 2014 10:59:21 +0800
Subject: [PATCH 0/5] *** pinctrl: sirf: a bundle of fixes for pin groups ***
Message-ID: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Barry.Song@csr.com>

hi Linus,
here it is a bundle of fixes for CSR SiRFprimaII and SiRFatlasVI including:

Bin Shi (1):
  pinctrl: sirf: fix the pins of sdmmc5 connected with TriG

Qipan Li (2):
  pinctrl: sirf: add lost usp1_uart_nostreamctrl group for atlas6
  ARM: dts: SiRF: add lost usp1_uart_nostreamctrl pin group for atlas6

Rongjun Ying (2):
  pinctrl: sirf: add pin group for USP0 with only RX or TX frame sync
  ARM: dts: SiRF: add pin group for USP0 with only RX or TX frame sync

 arch/arm/boot/dts/atlas6.dtsi         |    6 ++++
 arch/arm/boot/dts/prima2.dtsi         |   12 ++++++++
 drivers/pinctrl/sirf/pinctrl-atlas6.c |   24 ++++++++++++++++
 drivers/pinctrl/sirf/pinctrl-prima2.c |   48 ++++++++++++++++++++++++++++-----
 4 files changed, 83 insertions(+), 7 deletions(-)

-- 
1.7.5.4
