From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 15 Jun 2017 12:34:11 +0100
Subject: [GIT PULL] arm64: dts: juno: updates for v4.13
Message-ID: <e2f52cbd-7c6d-6a4e-1690-aa7e27f15805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull!

Regards,
Sudeep

--

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/juno-updates-4.13

for you to fetch changes up to 6806f2c70cfe145b3b6809242c8e1254071c1cf3:

  arm64: dts: juno: enable some SMMUs (2017-05-19 14:38:16 +0100)

----------------------------------------------------------------
ARMv8 Vexpress/Juno DT updates for v4.13

1. Adds support for Coresight CPU debug MMIO interface on all Juno variants.

2. Enables support for few SMMUs on Juno which were previously disabled
   waiting for IOMMU-backed DMA API support to be stabilised.

----------------------------------------------------------------
Robin Murphy (1):
      arm64: dts: juno: enable some SMMUs

Suzuki K Poulose (1):
      arm64: dts: juno: add coresight CPU debug nodes

 arch/arm64/boot/dts/arm/juno-base.dtsi | 58 +++++++++++++++++++++++---
 arch/arm64/boot/dts/arm/juno-r1.dts    | 24 ++++++++++++++
 arch/arm64/boot/dts/arm/juno-r2.dts    | 24 ++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts       | 24 ++++++++++++++
 4 files changed, 126 insertions(+), 4 deletions(-)
