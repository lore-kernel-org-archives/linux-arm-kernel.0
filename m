From: agross@codeaurora.org (Andy Gross)
Date: Tue, 13 Oct 2015 14:15:58 -0500
Subject: [GIT PULL] qcom defconfig for 4.4
Message-ID: <1444763758-16224-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git at git.codeaurora.org:quic/kernel/agross-msm.git tags/qcom-defconfig-for-4.4

for you to fetch changes up to 4e7fb93081f8f2ac9f190e8da7507956d3f3a936:

  ARM: multi_v7_defconfig: Enable QCOM SMD/RPM (2015-10-08 15:59:46 -0500)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.4

* Enable QCOM SMD/RPM in multi_v7_defconfig
* Enable QCOM SMD/RPM in qcom_defconfig

----------------------------------------------------------------
Andy Gross (2):
      ARM: qcom_defconfig: Enable SMD-RPM regulators
      ARM: multi_v7_defconfig: Enable QCOM SMD/RPM

 arch/arm/configs/multi_v7_defconfig |    5 +++++
 arch/arm/configs/qcom_defconfig     |    8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)
