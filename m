From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 24 Nov 2016 01:05:31 -0600
Subject: [GIT PULL] Qualcomm Driver Updates for v4.10 - Part 2
Message-ID: <1479971131-15142-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin, and Arnd,

Please consider taking this additional set of updates for 4.10.  These
apply on top of the previous tagged set of changes.


The following changes since commit e1ae0a7ee8849e12050933723e433a3d3ee26f7e:

  Merge tag 'qcom-drivers-for-4.10' into drivers-for-4.10-2 (2016-11-23 11:01:54 -0600)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.10-2

for you to fetch changes up to ed19b86e817c5f30d557042f2e8ab68dc93940d4:

  firmware: qcom: scm: Return PTR_ERR when devm_clk_get fails (2016-11-23 11:03:00 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.10 - Part 2

* Fixup QCOM SCM to support MSM8996

----------------------------------------------------------------
spjoshi at codeaurora.org (3):
      dt-bindings: firmware: scm: Add MSM8996 DT bindings
      firmware: qcom: scm: Remove core, iface and bus clocks dependency
      firmware: qcom: scm: Return PTR_ERR when devm_clk_get fails

 .../devicetree/bindings/firmware/qcom,scm.txt      |  2 +
 drivers/firmware/qcom_scm.c                        | 49 ++++++++++++++++------
 2 files changed, 39 insertions(+), 12 deletions(-)
