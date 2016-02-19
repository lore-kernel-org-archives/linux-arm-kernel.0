From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 19 Feb 2016 04:02:06 -0600
Subject: [GIT PULL] SoCFPGA defconfig for v4.6
Message-ID: <1455876126-26635-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling this defconfig update for v4.6.

Thanks,
Dinh

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_defconfig_for_v4.6

for you to fetch changes up to 31d74b2bf0c921276a1e987ca5371e2f79a783c2:

  ARM: socfpga_defconfig: enable support for initramfs/initrd support (2016-02-19 03:48:20 -0600)

----------------------------------------------------------------
SoCFPGA defconfig update for v4.6
-Enable initrd/initramfs support

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: socfpga_defconfig: enable support for initramfs/initrd support

 arch/arm/configs/socfpga_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
