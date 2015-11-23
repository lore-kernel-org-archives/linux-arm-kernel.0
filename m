From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Mon, 23 Nov 2015 10:54:53 -0800
Subject: [GIT PULL] Keystone fixes for 4.4-rcx
Message-ID: <1448304893-6103-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-fixes-for-4.4

for you to fetch changes up to 17e846aa390d89adae053d9d2ba8acb286b64af7:

  ARM: dts: keystone: k2l: fix kernel crash when clk_ignore_unused is not in bootargs (2015-11-23 10:36:27 -0800)

----------------------------------------------------------------
Few Keystone fixes for 4.4-rcx
	- Fix the optional PDSP firmware loading
	- Fix linking RAM setup for QMs
	- Fix crash with clk_ignore_unused

----------------------------------------------------------------
Michal Morawiec (1):
      soc: ti: knav_qmss_queue: Fix linking RAM setup for queue managers

Murali Karicheri (2):
      soc: ti: use request_firmware_direct() as acc firmware is optional
      ARM: dts: keystone: k2l: fix kernel crash when clk_ignore_unused is not in bootargs

 Documentation/arm/keystone/Overview.txt | 18 ------------------
 arch/arm/boot/dts/k2l-netcp.dtsi        |  2 +-
 drivers/soc/ti/knav_qmss_queue.c        |  8 ++++----
 3 files changed, 5 insertions(+), 23 deletions(-)
