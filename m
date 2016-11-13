From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 13 Nov 2016 00:15:36 -0600
Subject: [GIT PULL] Qualcomm SoC Updates for v4.10
In-Reply-To: <1479017736-13564-1-git-send-email-andy.gross@linaro.org>
References: <1479017736-13564-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1479017736-13564-6-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.10

for you to fetch changes up to e19811a89d0f566bb781959e151f244bd3bcde8a:

  arm64: qcom: enable GPIOLIB in Kconfig (2016-11-12 23:24:26 -0600)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.10

* Enable GPIOLIB for QCOM ARM64 platforms

----------------------------------------------------------------
Michael Scott (1):
      arm64: qcom: enable GPIOLIB in Kconfig

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)
