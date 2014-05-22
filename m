From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 May 2014 11:51:23 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.16 (incr. #2)
Message-ID: <20140522155123.GT8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

last round of defconfig changes.  Nothing earth-shattering here.  :)

Please pull.

thx,

Jason.


The following changes since commit 208f4e0d9bce775fbc7ab08c830d135d3da5777c:

  ARM: multi_v5_defconfig: Enable sound modules needed for t5325 (2014-05-05 01:22:11 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.16-2

for you to fetch changes up to 0105c9990291587a3b1fecb576f4d9b6728f1191:

  ARM: mvebu: enable MSI support in mvebu_v7_defconfig (2014-05-22 14:22:17 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.16 (incremental #2)

 - mvebu
    - enable MSI and XHCI in mvebu_v7_defconfig

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: configs: enable XHCI mvebu support in mvebu_v7_defconfig

Thomas Petazzoni (1):
      ARM: mvebu: enable MSI support in mvebu_v7_defconfig

 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)
