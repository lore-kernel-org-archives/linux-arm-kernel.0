From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 21 Jul 2018 23:10:22 -0500
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.19
In-Reply-To: <1532232622-18275-1-git-send-email-andy.gross@linaro.org>
References: <1532232622-18275-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1532232622-18275-5-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.19

for you to fetch changes up to b0c28f2765813e816740028dd85e64e46eee15a0:

  ARM: dts: qcom: Add missing OPP properties for CPUs (2018-07-21 16:18:14 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.19

* Add missing OPPs on IPQ4019
* Fix sdhci l20 load on Hammerhead
* Use proper IRQ macros for IPQ8064 interrupts

----------------------------------------------------------------
Bhushan Shah (1):
      ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for sdhci

Sricharan R (1):
      ARM: dts: qcom: Fix 'interrupts = <>' property to use proper macros

Viresh Kumar (1):
      ARM: dts: qcom: Add missing OPP properties for CPUs

 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 24 +++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi                | 41 +++++++++++++---------
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |  2 ++
 3 files changed, 50 insertions(+), 17 deletions(-)
