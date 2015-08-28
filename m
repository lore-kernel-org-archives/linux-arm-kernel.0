From: agross@codeaurora.org (Andy Gross)
Date: Fri, 28 Aug 2015 15:18:28 -0500
Subject: [GIT PULL] qcom SoC changes for 4.3-rc2 Part 2
Message-ID: <1440793108-10849-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3427446d72e21f6992534a3b68055f1b4c722546:

  soc: qcom: smd: Use correct remote processor ID (2015-08-27 12:15:58 -0500)

are available in the git repository at:

  git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-soc-for-4.3-rc2-1

for you to fetch changes up to 8208b90daca1a685eb19e90bbef23af00449f46c:

  soc: qcom: smd: Correct fBLOCKREADINTR handling (2015-08-28 14:54:08 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for 4.3-rc2-1

* Correct SMD fBLOCKREADINTR handling

----------------------------------------------------------------
Bjorn Andersson (1):
      soc: qcom: smd: Correct fBLOCKREADINTR handling

 drivers/soc/qcom/smd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
