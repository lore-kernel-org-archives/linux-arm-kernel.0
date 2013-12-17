From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 17 Dec 2013 09:42:42 -0500
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.14 (incr. #2)
Message-ID: <20131217144242.GJ2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Simple incremental change for the mvebu/defconfig branch.  From
tags/mvebu-defconfig-3.14 to tags/mvebu-defconfig-3.14-2.

thx,

Jason.


The following changes since commit 9ec1acb88698d3b5f181fe8621d259c59b392e49:

  ARM: kirkwood: enable HIGHMEM in defconfig (2013-11-23 17:17:13 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.14-2

for you to fetch changes up to 4427944b71a436785b95da95ac61520b2ac8053f:

  ARM: mvebu: config: Enable NAND support (2013-12-12 14:07:34 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.14 (incremental #2)

 - mvebu
    - enable nand support

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: config: Enable NAND support

 arch/arm/configs/mvebu_defconfig | 2 ++
 1 file changed, 2 insertions(+)
