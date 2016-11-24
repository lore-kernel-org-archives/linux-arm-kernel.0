From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 24 Nov 2016 01:05:41 -0600
Subject: [GIT PULL] Qualcomm ARM64 DT Updates for v4.10 - Part 2
Message-ID: <1479971141-15185-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin, and Arnd,

Please consider taking this additional set of updates for 4.10.  These
apply on top of the previous tagged set of changes.


The following changes since commit 58432d74c9a7233bcfb23ef1108308dd17980e44:

  Merge tag 'qcom-arm64-for-4.10' into arm64-for-4.10-2 (2016-11-23 11:10:57 -0600)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.10-2

for you to fetch changes up to c987775aa4af1034186ba17f67c21636451dc6d4:

  arm64: dts: qcom: msm8916: Add ddr support to sdhc1 (2016-11-24 00:33:26 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.10 - Part 2

* Add SDHC xo clk and 1.8V DDR support

----------------------------------------------------------------
Ritesh Harjani (2):
      ARM: dts: Add xo to sdhc clock node on qcom platforms
      arm64: dts: qcom: msm8916: Add ddr support to sdhc1

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 11 +++++++----
 arch/arm64/boot/dts/qcom/msm8996.dtsi |  9 +++++----
 2 files changed, 12 insertions(+), 8 deletions(-)
