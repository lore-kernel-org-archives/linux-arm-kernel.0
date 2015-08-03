From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Aug 2015 11:43:47 +0200
Subject: [GIT PULL] Allwinner defconfig changes for 4.3
Message-ID: <20150803094347.GA17185@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following defconfig patches for the 4.3 merge window.

Thanks!
Maxime

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-4.3

for you to fetch changes up to 8faf3554cb7a83413f9dfbe1a3420a81c52efe47:

  ARM: multi_v7_defconfig: Enable Allwinner P2WI, PWM, DMA_SUN6I, cryptodev (2015-07-31 20:01:24 +0200)

----------------------------------------------------------------
Allwinner defconfig changes for 4.3

Two patches that enable various Allwinner related drivers drivers both in
sunxi_defconfig and in multi_v7_defconfig

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: sunxi_defconfig: Enable DMA_SUN6I, P2WI, PWM, cryptodev, EXTCON, FHANDLE
      ARM: multi_v7_defconfig: Enable Allwinner P2WI, PWM, DMA_SUN6I, cryptodev

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/de98862f/attachment.sig>
