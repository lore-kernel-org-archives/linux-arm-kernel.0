From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 18 Jun 2018 14:58:58 +1000
Subject: [PATCH v2 0/4] arm: dts: Aspeed SoC device-tree update
Message-ID: <20180618045902.11453-1-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a few things in some Aspeed BMC device trees:

 - Fix an error in a memory reserve address on Romulus systems
 - Update AST2400 and AST2500 device-trees to add a label to the
   SRAM node and add the coprocessor interrupts controller node
   along with a binding.
