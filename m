From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Feb 2018 10:57:24 +0800
Subject: [GIT PULL] ZTE ZX fixes for 4.16
Message-ID: <20180222025723.GB3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

It contains only a fix for ZTE ZX296702 device tree, which has been
overlooked in 4.16 merge window [1].  So please consider to merge it for
4.16-rc as a fix.  Thanks.

Shawn

[1] https://lkml.org/lkml/2018/2/21/1571


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-fixes-4.16

for you to fetch changes up to c469943e87f6ec4617e69db7e5cea7e8f6dca586:

  arm: zx: dts: Remove leading 0x and 0s from bindings notation (2018-02-22 10:34:52 +0800)

----------------------------------------------------------------
ZTE ZX fixes for 4.16:
 - Remove all the leading "0x" and zeros from ZX296702 device tree to
   fix the dtc warnings.

----------------------------------------------------------------
Mathieu Malaterre (1):
      arm: zx: dts: Remove leading 0x and 0s from bindings notation

 arch/arm/boot/dts/zx296702.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)
