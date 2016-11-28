From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 28 Nov 2016 22:19:35 +0800
Subject: [GIT PULL] ZTE arm64 device tree updates for 4.10
Message-ID: <20161128141934.GA20556@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

If it's not too late, please pull this for 4.10.  It contains a single
patch which adds clock controller device nodes for zx296718.  Thanks.

Shawn


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-dt64-4.10

for you to fetch changes up to 392ce382743b847eded4b40990de4e78a5eb494d:

  arm64: dts: zx: Add clock controller nodes (2016-10-24 16:54:20 +0800)

----------------------------------------------------------------
ZTE arm64 device tree update for 4.10:

Add clock controller device nodes, including one top clock controller,
two low speed clock controllers and one audio clock controller.

----------------------------------------------------------------
Jun Nie (1):
      arm64: dts: zx: Add clock controller nodes

 arch/arm64/boot/dts/zte/zx296718.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
