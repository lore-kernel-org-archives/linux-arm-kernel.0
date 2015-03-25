From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Mar 2015 14:25:01 -0700
Subject: [GIT PULL] Allwinner defconfig changes for 4.1
Message-ID: <20150325212501.GA18485@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here are the Allwinner defconfig related changes for the 4.1 merge window.

Thanks!
Maxime

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-4.1

for you to fetch changes up to a198d27cb4d34de1fde22989c5fa536a951f6303:

  ARM: sunxi_defconfig: increase the number of maximum number of CPUs to 8 (2015-02-23 09:30:29 +0100)

----------------------------------------------------------------
Allwinner defconfig changes for 4.1

Nothing really standing out here, just a few options to enable in the defconfigs

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: sunxi_defconfig: Enable CONFIG_PHY_SUN9I_USB
      ARM: multi_v7_defconfig: Enable CONFIG_PHY_SUN9I_USB

Tyler Baker (1):
      ARM: sunxi_defconfig: increase the number of maximum number of CPUs to 8

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sunxi_defconfig    | 2 ++
 2 files changed, 3 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/65883345/attachment.sig>
