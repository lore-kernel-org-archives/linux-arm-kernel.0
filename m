From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 27 Jun 2016 21:49:57 -0500
Subject: [GIT PULL] Qualcomm ARM64 Defconfig Updates for v4.8
Message-ID: <1467082197-22809-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.8

for you to fetch changes up to f1a176f25aec6a2602040c62e09375596f4dc1a0:

  arm64: defconfig: enable msm8996 pinctrl support (2016-06-24 22:36:33 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.8

* Enable PM8xxx pwrkey support
* Enable MSM8996 support

----------------------------------------------------------------
Andy Gross (1):
      arm: defconfig: Enable PM8941 pwr key

Srinivas Kandagatla (1):
      arm64: defconfig: enable msm8996 pinctrl support

Stephen Boyd (1):
      arm64: defconfig: Enable qcom msm8996 clk drivers

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)
