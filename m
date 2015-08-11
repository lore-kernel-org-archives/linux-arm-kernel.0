From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Aug 2015 00:42:31 +0800
Subject: [GIT PULL 3/3] ARM: imx: defconfig updates for 4.3
In-Reply-To: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
References: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1439311351-5268-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.3

for you to fetch changes up to 9559b3a38b26ab8410aeb822cf0596ea0b4adde4:

  ARM: imx_v6_v7_defconfig: Select CONFIG_IKCONFIG_PROC (2015-07-27 22:33:50 +0800)

----------------------------------------------------------------
The i.MX defconfig updates for 4.3:
 - Enable i.MX6UL SoC build
 - Enable powerkey and syscon poweroff support
 - Build in multi-channel audio support, including i.MX ASRC and CS42xx8
   codec drivers.
 - Enable kexec build, HCIUART_H4 and IKCONFIG_PROC support.

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Enable kexec support
      ARM: imx_v6_v7_defconfig: Select HCIUART_H4
      ARM: imx_v6_v7_defconfig: Select CONFIG_IKCONFIG_PROC

Frank Li (2):
      ARM: imx_v6_v7_defconfig: enable powerkey and syscon power off
      ARM: imx: imx_v6_v7_defconfig enable imx6ul support

Shengjiu Wang (1):
      ARM: imx_v6_v7_defconfig: build in audio driver

 arch/arm/configs/imx_v6_v7_defconfig | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)
