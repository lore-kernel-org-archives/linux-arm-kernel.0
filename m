From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 21 Jun 2017 19:32:21 +0800
Subject: [GIT PULL] ZTE arm64 device tree updates for 4.13
Message-ID: <20170621113220.GB3372@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-dt64-4.13

for you to fetch changes up to 61c9e029912d4962c52361f0f7cb5f77c405f08b:

  arm64: dts: zte: Use - instead of @ for DT OPP entries (2017-06-21 19:05:38 +0800)

----------------------------------------------------------------
ZTE arm64 device tree updates for 4.13:
 - Fix DTC unit_address_vs_reg warnings in OPP entries by replacing
   '@' with '-' as the OPP nodes will never have a "reg" property.

----------------------------------------------------------------
Viresh Kumar (1):
      arm64: dts: zte: Use - instead of @ for DT OPP entries

 arch/arm64/boot/dts/zte/zx296718.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
