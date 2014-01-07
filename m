From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Jan 2014 00:08:48 +0100
Subject: [GIT PULL] Allwinner core changes for 3.14, take 2
Message-ID: <20140107230848.GA18498@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following patches on top of the previous pull request.

Thanks!

The following changes since commit 73346794b48237b7b4c2a5c02b12e3c4f1da7551:

  ARM: sun6i: Add SMP support for the Allwinner A31 (2013-12-16 21:33:41 +0100)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-core-for-3.14-2

for you to fetch changes up to 75cac6abe756fde529a000e725dceed2b908f61a:

  ARM: sunxi: select ARM_PSCI (2014-01-01 23:58:17 +0100)

----------------------------------------------------------------
Second round of core additions for the Allwinner SoCs

Fixes to select missing configuration options, and update of the maintainer
file.

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: sunxi: Select RESET_CONTROLLER
      MAINTAINERS: Update Allwinner sunXi maintainer files

Zalan Blenessy (1):
      ARM: sunxi: select ARM_PSCI

 MAINTAINERS                 | 7 ++++++-
 arch/arm/mach-sunxi/Kconfig | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/34ae0d38/attachment.sig>
