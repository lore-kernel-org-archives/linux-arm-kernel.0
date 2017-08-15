From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Aug 2017 09:52:25 -0700
Subject: [GIT PULL 3/4] non-urgent dts fixes for omaps for v4.14
In-Reply-To: <pull-1502815785-702769>
References: <pull-1502815785-702769>
Message-ID: <pull-1502815785-702769-3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit ff570a01b1bd15cf8a87c9ea774fc9c52ea07f15:

  ARM: dts: dra71-evm: mdio: Fix impedance values (2017-07-05 00:54:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/fixes-not-urgent-dt-signed

for you to fetch changes up to 83f51f06d132c5430b4ac5065ce3594fc4c99aaa:

  ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin strap (2017-08-10 10:32:17 -0700)

----------------------------------------------------------------
Two non-urgent dts fixes for dra7 Ethernet quirk. These are sent
separately from the rest of the dts changes to avoid merge conflicts
as these depend on earlier fixes sent during v4.13-rc cycle.

----------------------------------------------------------------
Sekhar Nori (2):
      ARM: dts: dra71-evm: workaround incorrect DP83867 RX_CTRL pin strap
      ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin strap

 arch/arm/boot/dts/dra71-evm.dts      | 2 ++
 arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
 2 files changed, 4 insertions(+)
