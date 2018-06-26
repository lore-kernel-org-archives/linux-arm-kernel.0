From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 26 Jun 2018 02:08:13 -0500
Subject: [GIT PULL] Qualcomm Fixes for v4.18-rc2
Message-ID: <1529996893-6390-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9573ce74d3bc797758cbd55194aae1b7248f2503:

  Merge tag 'qcom-fixes-for-4.18-rc1' into linus (2018-06-25 23:53:28 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-4.18-rc2

for you to fetch changes up to 0ea3fa15b12739c5455cd5850ada4e9948171213:

  qcom: cmd-db: enforce CONFIG_OF_RESERVED_MEM dependency (2018-06-25 23:54:38 -0500)

----------------------------------------------------------------
Qualcomm Fixes for v4.18-rc2

* Fix compiler warnings for cmd-db driver

----------------------------------------------------------------
Arnd Bergmann (1):
      qcom: cmd-db: enforce CONFIG_OF_RESERVED_MEM dependency

 drivers/soc/qcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
