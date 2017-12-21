From: dhaval.shah@xilinx.com (Dhaval Shah)
Date: Thu, 21 Dec 2017 10:33:04 -0800
Subject: [PATCH v6 0/2] Documentation and driver of logicoreIP
In-Reply-To: <CAK8P3a0z6HF8Rg08HUj7_T+7ZxxnHoReiu68bNzF6CnEooQSdA@mail.gmail.com>
References: <CAK8P3a0z6HF8Rg08HUj7_T+7ZxxnHoReiu68bNzF6CnEooQSdA@mail.gmail.com>
Message-ID: <1513881186-26020-1-git-send-email-dshah@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1st patch provide Device Tree binding document for logicoreIP
2nd patch provide the xlnx_vcu logicoreIP driver, Kconfig changes
and Makefile changes for the driver.

Dhaval Shah (2):
  dt-bindings: misc: Add DT bindings to xlnx_vcu driver
  misc: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver

 .../devicetree/bindings/soc/xilinx/xlnx,vcu.txt    |  31 +
 drivers/soc/xilinx/Kconfig                         |  15 +
 drivers/soc/xilinx/Makefile                        |   1 +
 drivers/soc/xilinx/xlnx_vcu.c                      | 630 +++++++++++++++++++++
 4 files changed, 677 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,vcu.txt
 create mode 100644 drivers/soc/xilinx/xlnx_vcu.c

-- 
2.7.4
