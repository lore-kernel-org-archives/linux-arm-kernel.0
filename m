From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 25 Apr 2016 13:19:32 -0500
Subject: [GIT PULL] Qualcomm SoC Updates for v4.7 part 2
Message-ID: <1461608372-19687-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd/Olof/Kevin,

This pull request is part 2 for my 4.7 SoC changes.  These two patches are based
on top of the qcom-soc-for-4.7 tag.

Regards,

Andy


The following changes since commit b55b592ee374d3f04f41c2e6fd259ca2c0f1d333:

  Merge tag 'qcom-soc-for-4.7' into soc-for-4.7-p2 (2016-04-19 21:39:16 -0500)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.7-2

for you to fetch changes up to b853cb9628bfbcc4017da46d5f5b46e3eba9d8c6:

  soc: qcom: smd: Make callback pass channel reference (2016-04-19 21:55:12 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.7 part 2

* Change SMD callback parameters
* Use writecombine mapping for SMEM

----------------------------------------------------------------
Bjorn Andersson (2):
      soc: qcom: smem: Use write-combine remap for SMEM
      soc: qcom: smd: Make callback pass channel reference

 drivers/soc/qcom/smd-rpm.c    |  9 ++++++---
 drivers/soc/qcom/smd.c        | 22 ++++++++++++++++++----
 drivers/soc/qcom/smem.c       |  3 +--
 drivers/soc/qcom/wcnss_ctrl.c |  8 ++++----
 include/linux/soc/qcom/smd.h  |  7 +++++--
 5 files changed, 34 insertions(+), 15 deletions(-)
