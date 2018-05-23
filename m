From: ilialin@codeaurora.org (Ilia Lin)
Date: Wed, 23 May 2018 16:11:29 +0300
Subject: [PATCH v11 0/2] CPU scaling support for msm8996 DT
Message-ID: <1527081091-13389-1-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[v11]
 * Split the series into domains

The series adds OPP tables, thermal and CPU definitions in order to support
the CPU frequency scaling on msm8996 CPUs.

Ilia Lin (2):
  dt: qcom: Add opp and thermal to the msm8996
  dt: qcom: Add qcom-cpufreq-kryo driver configuration

 arch/arm64/boot/dts/qcom/apq8096-db820c.dts |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi       | 546 +++++++++++++++++++++++++++-
 2 files changed, 528 insertions(+), 20 deletions(-)

-- 
1.9.1
