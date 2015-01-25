From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 18:40:06 +0100
Subject: [GIT PULL] Allwinner defconfig for 3.20
Message-ID: <20150125174006.GA27061@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following defconfig changes for the 3.20 merge window.

Thanks!
Maxime

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-3.20

for you to fetch changes up to fef3f0dde681a32f148b765ee8e1465fba9b3cd4:

  ARM: sunxi: Add AXP20x support multi_v7_defconfig (2015-01-06 17:33:31 +0100)

----------------------------------------------------------------
Allwinner defconfig changes for 3.20

Defconfig changes for both sunxi and multi_v7 defconfig in order to add the
cpufreq-related drivers and the PMIC drivers.

----------------------------------------------------------------
Carlo Caione (2):
      ARM: sunxi: Add AXP20x support in defconfig
      ARM: sunxi: Add AXP20x support multi_v7_defconfig

Chen-Yu Tsai (2):
      ARM: sunxi_defconfig: Enable TOUCHSCREEN_SUN4I, CPUFREQ_DT, CPU_THERMAL
      ARM: multi_v7_defconfig: Enable TOUCHSCREEN_SUN4I, CPU_THERMAL

 arch/arm/configs/multi_v7_defconfig |  5 +++++
 arch/arm/configs/sunxi_defconfig    | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/6a40a6fc/attachment-0001.sig>
