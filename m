From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 4 Mar 2014 11:19:21 +0800
Subject: [GIT PULL] pull request from pxa
Message-ID: <CAN1soZyZOR8o3VGAfWDftp-m=o6-+4yhRaJiFT8Uh4BSbaCAgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
Hi all,

Please help to pull request from pxa git tree.

Best Regards
Haojian


  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git tags/pxa

for you to fetch changes up to dc5dfab4ed18f0756f304dc5699b5743ddf56f90:

  ARM: pxa: add gpio keys information (2014-03-04 09:17:01 +0800)

----------------------------------------------------------------
append gpio keys on corgi

----------------------------------------------------------------
Dmitry Eremin-Solenikov (1):
      ARM: pxa: add gpio keys information

 arch/arm/mach-pxa/corgi.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
