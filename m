From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 00:01:32 -0600
Subject: [Resend 0/2] Add support for APQ8084 and MSM8916 Regulators
Message-ID: <1449813694-11211-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is a resend of the regulator portion of the patches
found at:

https://lkml.org/lkml/2015/9/24/561

This adds support for the PMA8084 regulators found on APQ8084 platforms
and the PM8916 regulators found on MSM8916 platforms.  There are no changes from
the version referenced above, this is just a resend.

Andy Gross (2):
  regulator: qcom-smd: Add PM8916 support
  regulator: qcom-smd: Add support for PMA8084

 .../bindings/soc/qcom/qcom,smd-rpm-regulator.txt   |  53 +++++++
 drivers/regulator/qcom_smd-regulator.c             | 159 +++++++++++++++++++++
 2 files changed, 212 insertions(+)

-- 
1.9.1
