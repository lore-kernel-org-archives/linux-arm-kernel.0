From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Thu, 16 Jul 2015 18:41:13 -0400
Subject: [PATCH 0/2] ARM: Couple of dts fixes for v4.2-rcx
Message-ID: <1437086473-21437-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts-fixes

for you to fetch changes up to 8b4769cc535adf9dd4ae5d82725ca1de254f007c:

  ARM: keystone: dts: rename pcie nodes to help override status (2015-07-16 18:13:03 -0400)

----------------------------------------------------------------
Couple of DTS fixes 4.2-rcx for Keystone EVMs:

K2E EVM boot hangs because of missing serdes driver which is needed to bring up
PCIe on K2E. These couple of fixes makes the PCIE disabled on common default and
let the specific board DTS to enable it.

----------------------------------------------------------------
Murali Karicheri (2):
      ARM: keystone: dts: fix dt bindings for PCIe
      ARM: keystone: dts: rename pcie nodes to help override status

 arch/arm/boot/dts/k2e.dtsi      | 3 ++-
 arch/arm/boot/dts/keystone.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
