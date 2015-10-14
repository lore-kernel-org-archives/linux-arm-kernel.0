From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 14 Oct 2015 08:37:38 -0700
Subject: [GIT PULL 2/2] ARM Keystone DTS part2 for 4.4
In-Reply-To: <1444837058-3525-1-git-send-email-ssantosh@kernel.org>
References: <1444837058-3525-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1444837058-3525-2-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 91dca0f0fe419813b7450b0d092e9e23255db51b:

  ARM: dts: keystone: Update SoC specific compatible flags (2015-10-06 09:51:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts-part2

for you to fetch changes up to 9d45708f5adb940432bc99325d67ddc813bc4b22:

  ARM: dts: keystone: enable accumulator channels (2015-10-13 13:42:43 -0700)

----------------------------------------------------------------
ARM Keystone DTS part2 for 4.4
	- Typo fix the soc binding documentation
	- NETCP Accumulator nodes

----------------------------------------------------------------
Murali Karicheri (1):
      ARM: dts: keystone: enable accumulator channels

Nishanth Menon (1):
      Documentation: dt: keystone: Fix up missing quotes

 .../devicetree/bindings/arm/keystone/keystone.txt  |  6 +++---
 arch/arm/boot/dts/k2e-netcp.dtsi                   | 23 +++++++++++++++++++++
 arch/arm/boot/dts/k2hk-netcp.dtsi                  | 24 ++++++++++++++++++++++
 arch/arm/boot/dts/k2l-netcp.dtsi                   | 23 +++++++++++++++++++++
 4 files changed, 73 insertions(+), 3 deletions(-)
