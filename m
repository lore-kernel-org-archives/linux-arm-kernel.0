From: andy.gross@linaro.org (Andy Gross)
Date: Sat,  2 Apr 2016 21:45:08 -0500
Subject: [GIT PULL] Qualcomm Fixes for v4.6-rc2
Message-ID: <1459651508-5160-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-4.6-rc2

for you to fetch changes up to 10c0f0e92f019ab8d0c17da3696e35b0eef4ec16:

  Revert "dts: msm8974: Add dma channels for blsp2_i2c1 node" (2016-04-02 21:27:36 -0500)

----------------------------------------------------------------
Qualcomm Fixes for v4.6-rc2

* Revert BAM usage on MSM8974 boards

----------------------------------------------------------------
Andy Gross (2):
      Revert "dts: msm8974: Add blsp2_bam dma node"
      Revert "dts: msm8974: Add dma channels for blsp2_i2c1 node"

 arch/arm/boot/dts/qcom-msm8974.dtsi | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)
