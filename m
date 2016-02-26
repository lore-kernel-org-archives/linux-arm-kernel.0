From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Feb 2016 11:45:45 -0800
Subject: [GIT PULL] arm: Allwinner core changes for 4.6
Message-ID: <20160226194545.GA20331@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-4.6

for you to fetch changes up to 1425ec0f1ce46c95838c797a721bf9c6e0be14e2:

  ARM: sunxi: Introduce Allwinner for A83T support (2016-02-05 07:54:08 +0100)

----------------------------------------------------------------
Allwinner core changes for 4.6

Just introduce the A83T support.

----------------------------------------------------------------
Vishnu Patekar (1):
      ARM: sunxi: Introduce Allwinner for A83T support

 Documentation/arm/sunxi/README                  | 1 -
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/f82f0aee/attachment.sig>
