From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Sat, 21 Jan 2017 15:02:36 -0800
Subject: [GIT_PULL 1/3] ARM: Keystone DTS for 4.11
Message-ID: <1485039758-15248-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.11

for you to fetch changes up to 0623013ca629d311be2114314ddaf220604493d3:

  ARM: dts: keystone-k2e: Add PSC reset controller node (2017-01-19 09:44:11 -0800)

----------------------------------------------------------------
ARM: Keystone DTS update for 4.11

Brief:
	- MSM RAM node support for the Keystone 2 SOCs.
	- PSC node & reset controller node support for keystone 2 SOCs.
	- da830 UART node support.

----------------------------------------------------------------
David Lechner (1):
      ARM: dts: keystone: Add "ti,da830-uart" compatible string

Murali Karicheri (1):
      ARM: keystone: dts: fix netcp clocks and add names

Suman Anna (12):
      ARM: dts: keystone-k2hk: Add MSM RAM node
      ARM: dts: keystone-k2l: Add MSM RAM node
      ARM: dts: keystone-k2e: Add MSM RAM node
      ARM: dts: keystone-k2g: Add MSM RAM node
      ARM: dts: keystone-k2hk: Reserve MSM RAM for boot monitor
      ARM: dts: keystone-k2l: Reserve MSM RAM for boot monitor
      ARM: dts: keystone-k2e: Reserve MSM RAM for boot monitor
      ARM: dts: keystone-k2g: Reserve MSM RAM for boot monitor
      ARM: dts: keystone: Add PSC node
      ARM: dts: keystone-k2hk: Add PSC reset controller node
      ARM: dts: keystone-k2l: Add PSC reset controller node
      ARM: dts: keystone-k2e: Add PSC reset controller node

 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  |  3 ++-
 arch/arm/boot/dts/keystone-k2e.dtsi        | 25 +++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi        | 14 ++++++++++++-
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi |  3 ++-
 arch/arm/boot/dts/keystone-k2hk.dtsi       | 32 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  |  3 ++-
 arch/arm/boot/dts/keystone-k2l.dtsi        | 32 ++++++++++++++++++++++++++++--
 arch/arm/boot/dts/keystone.dtsi            |  9 +++++++--
 8 files changed, 113 insertions(+), 8 deletions(-)
