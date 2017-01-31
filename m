From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 31 Jan 2017 17:29:49 -0600
Subject: [GIT PULL] Qualcomm ARM64 DT Updates for v4.11 Part 2
Message-ID: <1485905389-32657-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3a52153975f7e2cda90ad36f3a63104610da657f:

  arm64: dts: db820c: add support to volume up key (2017-01-13 13:17:29 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.11-2

for you to fetch changes up to 7c10da3736983ac296b381ca9db2e33932efacce:

  arm64: dts: qcom: Add msm8916 CoreSight components (2017-01-31 17:23:17 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.11 Part 2

* Add CoreSight nodes for MSM8916

----------------------------------------------------------------
Ivan T. Ivanov (1):
      arm64: dts: qcom: Add msm8916 CoreSight components

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 240 ++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)
