From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 28 Dec 2016 14:58:12 -0600
Subject: [GIT PULL] Qualcomm ARM64 Fixes for 4.10-rc1
Message-ID: <1482958692-18978-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-4.10-rc1

for you to fetch changes up to e9112936f240856c925321fd2bd91adc7c00399c:

  arm64: dts: msm8996: Add required memory carveouts (2016-12-28 14:50:33 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Fixes for v4.10-rc1

* Fix instability in MSM8996 due to incorrect carveouts

----------------------------------------------------------------
Stephen Boyd (1):
      arm64: dts: msm8996: Add required memory carveouts

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)
