From: edgar.righi@lsitec.org.br (Edgar Bernardi Righi)
Date: Wed, 18 Jul 2018 12:27:56 -0300
Subject: [PATCH v1 00/04] Add clock driver for Actions Semi S500 SoC
Message-ID: <CADHB5bA2KiPSN32+G-Oyf9AfOkFrOB48sc54K5rFem9+xyWtAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds clock support for Actions Semi Owl series S500 SoC
with relevant clock bindings and device tree info.

This patchset depends on patch "[PATCH v6 1/5] clk: actions: Add
missing REGMAP_MMIO dependency" by Saravanan Sekar.
This patchset depends on patch "[PATCH] clk: actions: Add custom delay
option to Actions Semi OWL pll clock driver" by Edgar Bernardi Righi.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
