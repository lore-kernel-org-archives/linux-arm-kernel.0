From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 23 Jun 2017 14:02:21 -0500
Subject: [GIT PULL] Qualcomm Defconfig updates for 4.13 - Part 2
Message-ID: <1498244541-9138-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0a932693c95ed5ed22506f09af084d8d3c299393:

  Merge tag 'qcom-defconfig-for-4.13' into defconfig-for-4.13-2 (2017-06-23 13:29:31 -0500)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-defconfig-for-4.13-2

for you to fetch changes up to 7f794788dbf9e1a9ca9a5c1cc0a90642f3b4e4ce:

  ARM: qcom_defconfig: enable RPMSG_QCOM_SMD (2017-06-23 13:29:39 -0500)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.13 - Part 2

* Enable RPMSG_QCOM_SMD to get boards working again

----------------------------------------------------------------
Bhushan Shah (1):
      ARM: qcom_defconfig: enable RPMSG_QCOM_SMD

 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)
