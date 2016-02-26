From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Feb 2016 11:43:52 -0800
Subject: [GIT PULL] arm64: Allwinner config changes for 4.6
Message-ID: <20160226194352.GA19388@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-config64-for-4.6

for you to fetch changes up to 22b0898e831bc1ffb64ce0b8452a376f0892b478:

  arm64: add defconfig options for Allwinner SoCs (2016-02-25 10:51:50 -0800)

----------------------------------------------------------------
Allwinner configuration changes for ARM64, 4.6 edition

Not a lot of changes for this kernel release, just a new Kconfig option and
some changes to the arm64 defconfig to add Allwinner drivers

----------------------------------------------------------------
Andre Przywara (2):
      arm64: Introduce Allwinner SoC config option
      arm64: add defconfig options for Allwinner SoCs

 arch/arm64/Kconfig.platforms | 5 +++++
 arch/arm64/configs/defconfig | 7 +++++++
 2 files changed, 12 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/f8c83d02/attachment.sig>
