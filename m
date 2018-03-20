From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 19 Mar 2018 21:27:59 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.17
In-Reply-To: <1521512881-1854-1-git-send-email-andy.gross@linaro.org>
References: <1521512881-1854-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1521512881-1854-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.17

for you to fetch changes up to e723795c702b52cfceb3bb3faa63059eb4658313:

  arm64: dts: qcom: Fix SPI5 config on MSM8996 (2018-03-08 18:39:19 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.17

* Fix GIC_CPU_MASK_SIMPLE and SPI5 config on MSM8996
* Add SDM845 and kryo385 documentation
* Add MSM8916 cooling maps, cpu frequency scaling, APCS, and A53 PLL
* Switch APCS to use mailbox on MSM8916
* Add rmtfs-mem on MSM8996

----------------------------------------------------------------
Bjorn Andersson (1):
      arm64: dts: msm8996: Add rmtfs sharedmem node

Georgi Djakov (4):
      arm64: dts: qcom: msm8916: Add msm8916 A53 PLL DT node
      arm64: dts: qcom: msm8916: Probe the APCS mailbox driver
      arm64: dts: qcom: msm8916: Add clock properties to the APCS node
      arm64: dts: qcom: msm8916: Add CPU frequency scaling support

Ilia Lin (1):
      arm64: dts: qcom: Fix SPI5 config on MSM8996

Rajendra Nayak (4):
      arm64: dts: msm8996: Fix wrong use of GIC_CPU_MASK_SIMPLE()
      arm64: dts: msm8916: Add cpu cooling maps
      dt-bindings: arm: Document kryo385 cpu
      dt-bindings: qcom: Add SDM845 bindings

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 Documentation/devicetree/bindings/arm/qcom.txt |  1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi          | 60 ++++++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi          | 23 +++++++---
 4 files changed, 76 insertions(+), 9 deletions(-)
