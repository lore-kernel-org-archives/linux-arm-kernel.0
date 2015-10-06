From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Tue,  6 Oct 2015 10:19:20 -0700
Subject: [GIT PULL 3/3] Kestone DTS updates for 4.4
In-Reply-To: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
References: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1444151960-4941-3-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts

for you to fetch changes up to 91dca0f0fe419813b7450b0d092e9e23255db51b:

  ARM: dts: keystone: Update SoC specific compatible flags (2015-10-06 09:51:09 -0700)

----------------------------------------------------------------
ARM Keystone DTS updates:
	- Add SOC compatible along with EVMs for future board variations.
	- Add SPI nodes

----------------------------------------------------------------
Franklin S Cooper Jr (1):
      ARM: dts: keystone: Add ti,keystone-spi for SPI

Nishanth Menon (3):
      Documentation: dt: keystone: provide SoC specific compatible flags
      ARM: keystone: Update compatible to have SoC specific matches
      ARM: dts: keystone: Update SoC specific compatible flags

 .../devicetree/bindings/arm/keystone/keystone.txt    | 20 +++++++++++++++++---
 arch/arm/boot/dts/k2e-evm.dts                        |  2 +-
 arch/arm/boot/dts/k2e.dtsi                           |  3 +++
 arch/arm/boot/dts/k2hk-evm.dts                       |  2 +-
 arch/arm/boot/dts/k2hk.dtsi                          |  3 +++
 arch/arm/boot/dts/k2l-evm.dts                        |  2 +-
 arch/arm/boot/dts/k2l.dtsi                           |  3 +++
 arch/arm/boot/dts/keystone.dtsi                      |  7 ++++---
 arch/arm/mach-keystone/keystone.c                    |  3 +++
 9 files changed, 36 insertions(+), 9 deletions(-)
