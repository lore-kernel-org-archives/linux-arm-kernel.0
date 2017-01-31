From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 09:49:57 +0100
Subject: [GIT PULL] Allwinner defconfig changes for 4.11
Message-ID: <20170131084957.73t2gjeyllh4gmlk@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-4.11

for you to fetch changes up to 11937f69b65b08d3184b1ebc864668be4b6c5427:

  ARM: sunxi: Add CONFIG_THERMAL_OF (2017-01-02 22:27:19 +0100)

----------------------------------------------------------------
Allwinner defconfig changes for 4.11

A single patch to enable the thermal DT support in sunxi_defconfig

----------------------------------------------------------------
Quentin Schulz (1):
      ARM: sunxi: Add CONFIG_THERMAL_OF

 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/7ba20b12/attachment.sig>
