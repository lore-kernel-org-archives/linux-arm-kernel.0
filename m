From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 00:13:03 -0600
Subject: [Patch v4 0/2] Add SMEM nodes for APQ8084 and MSM8916
Message-ID: <1449814385-11970-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the SMEM nodes for the APQ8084 and MSM8916 platforms.  These
patches were originally part of:
https://lkml.org/lkml/headers/2015/9/24/561

I split these two patches out because these were the only DTS patches that
required modifications.  The rest have been accepted.  I continued to add the
previous change log for continuity sake.

Changes since v3:
- Moved smem node outside of soc and fixed up the rpm-msg-ram

Changes since v2:
- Fixed some missed review comments
- Corrected the SMD RPM example binding indentation

Changes since v1:
- Fixed various review comments
- Removed MSM8974 patches as there was already an outstanding patch

Andy Gross (2):
  arm64: dts: qcom: Add MSM8916 SMEM nodes
  arm: dts: Add APQ8084 SMEM nodes

 arch/arm/boot/dts/qcom-apq8084.dtsi   | 36 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

-- 
1.9.1
