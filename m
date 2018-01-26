From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 26 Jan 2018 09:23:49 +0100
Subject: [PATCH 0/3] ARM: dts: imx6ull: fix some incompatibilities between
 i.MX6UL and i.MX6ULL
Message-ID: <1516955032-21167-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset addresses some differences between i.MX6UL and i.MX6ULL
which have slipped through the cracks so far.

- UART8 is not on SPBA but on AIPS-3
- i.MX6ULL has an ESAI interface in the address range of the UART8 on i.MX6UL
- i.MX6ULL does not have a CAAM unit nor SIM interfaces
