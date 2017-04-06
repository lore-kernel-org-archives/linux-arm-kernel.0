From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Apr 2017 10:35:39 +0200
Subject: [GIT PULL] Allwinner defconfig changes for 4.12
Message-ID: <20170406083539.qhowtju6helnxm7v@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are some defconfig changes for the next merge window.

Thanks!
Maxime

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-defconfig-for-4.12

for you to fetch changes up to 7cae7ef89e360cd3dc139eaac2f480c25bc7bfa1:

  ARM: multi_v7_defconfig: Switch AXP20x driver from module to built-in (2017-03-06 07:38:15 +0100)

----------------------------------------------------------------
Allwinner defconfig changes for 4.12

Some patches to enable new modules in the defconfig.

----------------------------------------------------------------
Rask Ingemann Lambertsen (4):
      ARM: sunxi_defconfig: Enable AC100 RTC driver
      ARM: multi_v7_defconfig: Switch sunxi RSB driver from module to built-in
      ARM: multi_v7_defconfig: Enable AC100 RTC driver
      ARM: multi_v7_defconfig: Switch AXP20x driver from module to built-in

 arch/arm/configs/multi_v7_defconfig | 10 ++++++----
 arch/arm/configs/sunxi_defconfig    |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/5bb46250/attachment.sig>
