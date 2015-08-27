From: agross@codeaurora.org (Andy Gross)
Date: Thu, 27 Aug 2015 16:28:19 -0500
Subject: [GIT PULL] qcom SoC changes for 4.3-rc2
Message-ID: <1440710899-29214-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 72af1ff60d08a57e223b9753f9c52396fb4c3897:

  Merge tag 'qcom-soc-for-4.3' into for-soc-new (2015-08-27 12:14:29 -0500)

are available in the git repository at:


  git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-soc-for-4.3-rc2

for you to fetch changes up to 3427446d72e21f6992534a3b68055f1b4c722546:

  soc: qcom: smd: Use correct remote processor ID (2015-08-27 12:15:58 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for 4.3-rc2

* Fix errant private access in SMEM
* Fix use of correct remote processor ID in SMD transactions

----------------------------------------------------------------
Andy Gross (2):
      soc: qcom: smem: Fix errant private access
      soc: qcom: smd: Use correct remote processor ID

 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |    6 ++++++
 drivers/soc/qcom/smd.c                             |   16 ++++++++++++----
 drivers/soc/qcom/smem.c                            |   18 ++++++------------
 3 files changed, 24 insertions(+), 16 deletions(-)
