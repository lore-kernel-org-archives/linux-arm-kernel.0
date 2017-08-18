From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 18 Aug 2017 16:01:45 -0500
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.14
Message-ID: <1503090105-1569-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.14

for you to fetch changes up to dc6159fd04624f5953f833f36428e9c118f4f022:

  arm64: defconfig: Enable QCOM IPQ8074 clock and pinctrl (2017-08-18 15:48:50 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.14

* Enable Qualcomm IPQ8074 clocks and pinctrl

----------------------------------------------------------------
Abhishek Sahu (1):
      arm64: defconfig: Enable QCOM IPQ8074 clock and pinctrl

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
