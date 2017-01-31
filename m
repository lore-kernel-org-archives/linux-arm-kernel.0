From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 09:45:36 +0100
Subject: [GIT PULL] Allwinner core changes for 4.11
Message-ID: <20170131084536.kddqcwrcfkwsrt5r@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following patches for the next merge window.

Thanks!
Maxime

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-4.11

for you to fetch changes up to b074fede01c0be4a45a7883620f40ff88c61488a:

  arm: sunxi: add support for V3s SoC (2017-01-20 21:31:34 +0100)

----------------------------------------------------------------
Allwinner core changes for 4.11

Some patches to support two new SoCs: the H2+ and the V3s.

----------------------------------------------------------------
Icenowy Zheng (2):
      ARM: sunxi: add support for H2+ SoC
      arm: sunxi: add support for V3s SoC

 Documentation/arm/sunxi/README                  | 8 ++++++++
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 2 ++
 3 files changed, 11 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/b7d1867c/attachment.sig>
