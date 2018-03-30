From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 30 Mar 2018 18:44:11 +0900
Subject: [PATCH 0/3] clk: uniphier: add support for PCIe, SATA and ethernet
Message-ID: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock lines for PCI-express and SATA controllers implemented on
UniPhier SoCs, and additional clock lines for ethernet controller on Pro4.

Kunihiko Hayashi (3):
  clk: uniphier: add PCIe clock control support
  clk: uniphier: add SATA clock control support
  clk: uniphier: add additional ethernet clock lines for Pro4

 drivers/clk/uniphier/clk-uniphier-sys.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.7.4
