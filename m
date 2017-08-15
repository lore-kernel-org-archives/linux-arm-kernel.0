From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Aug 2017 09:52:24 -0700
Subject: [GIT PULL 2/4] defconfig changes for omaps for v4.14
In-Reply-To: <pull-1502815785-702769>
References: <pull-1502815785-702769>
Message-ID: <pull-1502815785-702769-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 9b51f04424e17051a89ab32d892ca66b2a104825:

  Merge branch 'parisc-4.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2017-07-05 17:41:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/defconfig-signed

for you to fetch changes up to 6a60a2aca111fd71c5229dbcb3de8ecf0e0e9a12:

  ARM: omap2plus_defconfig: Enable LP87565 (2017-08-14 10:33:49 -0700)

----------------------------------------------------------------
Defconfig updates for omaps for v4.14 to enable DP83867
phy driver on dra72x and dra71x evm, and LP87565 that is
on dra76-evm.

----------------------------------------------------------------
Lokesh Vutla (1):
      ARM: omap2plus_defconfig: Enable LP87565

Sekhar Nori (1):
      ARM: omap2plus_defconfig: enable DP83867 phy driver

 arch/arm/configs/omap2plus_defconfig | 4 ++++
 1 file changed, 4 insertions(+)
