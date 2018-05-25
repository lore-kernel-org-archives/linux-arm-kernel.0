From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 24 May 2018 22:55:09 -0500
Subject: [GIT PULL] Qualcomm Driver Fixes for 4.17-rc7
Message-ID: <1527220509-23245-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-4.17-rc7

for you to fetch changes up to 5ec3444c8346c922316f4effafa8afc17defda0e:

  firmware: qcom: scm: Fix crash in qcom_scm_call_atomic1() (2018-05-24 22:36:45 -0500)

----------------------------------------------------------------
Qualcomm Fixes for 4.17-rc7

* Fix crash in qcom_scm_call_atomic1()

----------------------------------------------------------------
Niklas Cassel (1):
      firmware: qcom: scm: Fix crash in qcom_scm_call_atomic1()

 drivers/firmware/qcom_scm-32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
