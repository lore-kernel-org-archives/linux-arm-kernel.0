From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Sep 2012 15:54:59 +0800
Subject: [GIT PULL 4/4] mxs defconfig update for 3.7
In-Reply-To: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
References: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347350100-4674-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-defconfig-3.7

for you to fetch changes up to 8f9d87a0b2ec18416a8ad1a53dd5a97ee4ef7825:

  ARM: mxs_defconfig: Add SPI and LRADC support (2012-08-28 08:38:05 +0800)

----------------------------------------------------------------
mxs-defconfig-3.7

A collection of mxs_defconfig updates for 3.7.

----------------------------------------------------------------
Fabio Estevam (4):
      ARM: mxs_defconfig: Enable USB host
      ARM: mxs_defconfig: Add LED, PWM and MTD_CHAR support
      ARM: mxs_defconfig: Add framebuffer support
      ARM: mxs_defconfig: Add SPI and LRADC support

 arch/arm/configs/mxs_defconfig |   36 [32m+++++++++++++++++++++++++++++++++++[m[31m-[m
 1 file changed, 35 insertions(+), 1 deletion(-)
