From: andy.gross@linaro.org (Andy Gross)
Date: Mon,  2 Jan 2017 14:03:54 -0600
Subject: [GIT PULL] Qualcomm ARM DT Fixes for 4.10-rc2
Message-ID: <1483387434-4655-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm-fixes-for-4.10-rc2

for you to fetch changes up to 542b9f0759ed74ca0f1a9f3ff090c95ea73eba91:

  ARM: dts: qcom: apq8064: Add missing scm clock (2017-01-02 10:47:10 -0600)

----------------------------------------------------------------
Qualcomm ARM DTS Fixes for v4.10-rc2

* Add SCM clock for APQ8064 to fix boot failures

----------------------------------------------------------------
Bjorn Andersson (1):
      ARM: dts: qcom: apq8064: Add missing scm clock

 arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++++
 1 file changed, 4 insertions(+)
