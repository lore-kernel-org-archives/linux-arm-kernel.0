From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 25 Nov 2016 17:50:05 +0800
Subject: [GIT PULL] ARM: berlin: DT changes for v4.10
Message-ID: <20161125175005.7b9f8396@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the first time I send pull request for berlin SoC. This is a PR for
the Berlin DT changes for v4.10. Please pull.

Thanks,
Jisheng

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin-dt-for-v4.10-1

for you to fetch changes up to 0248994d7cce890e9bb75a8ee2d41016c990a7fd:

  ARM: dts: berlin2q-marvell-dmp: fix typo in chosen node (2016-11-25 16:52:18 +0800)

----------------------------------------------------------------
Berlin DT changes for v4.10

- fix DTC compiler warning
- fix typo in chosen node

----------------------------------------------------------------
Jisheng Zhang (1):
      ARM: dts: berlin2q-marvell-dmp: fix regulators' name

Masahiro Yamada (1):
      ARM: dts: berlin2q-marvell-dmp: fix typo in chosen node

 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
