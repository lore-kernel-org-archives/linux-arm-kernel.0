From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  1 Mar 2016 23:00:02 +0800
Subject: [GIT PULL 3/4] arm64: nxp: device tree changes for 4.6
In-Reply-To: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
References: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1456844403-26176-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

This is the first time I help to collect NXP/Freescale arm64 dts
patches.  I used to ignore such patches, because they do not belong
to i.MX family.  But since people keep sending me patches, I decided
to help accelerate the process for getting these patches land on
mainline.

I should probably start naming my branches and tags like nxp/* from the
next cycle.

Shawn

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.6

for you to fetch changes up to 4c1d9ea7402dd808fc511ef6622f957aa795852f:

  arm64: dts: ls1043a: Add quirk for Erratum A009116 (2016-02-14 16:44:15 +0800)

----------------------------------------------------------------
The NXP/Freescale arm64 dts update for 4.6:
- Add "snps,quirk-frame-length-adjustment" property to USB3 node for
  erratum A009116, which affects NXP/Freescale arm64 SoCs LS1043A and
  LS2080A.

----------------------------------------------------------------
Lijun Pan (1):
      arm64: dts: ls2080a: Add quirk for Erratum A009116

Rajesh Bhagat (1):
      arm64: dts: ls1043a: Add quirk for Erratum A009116

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 2 ++
 2 files changed, 5 insertions(+)
