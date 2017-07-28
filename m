From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 27 Jul 2017 23:35:32 -0500
Subject: [GIT PULL] Qualcomm ARM64 defconfig fixes for v4.13-rc2
Message-ID: <1501216532-31021-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, and Kevin,

Recent changes to the hwspinlock Kconfig changed the behavior for enabling
the hwspinlock driver.  This patch fixes the defconfig to make the current
hwspinlock selections work as they did before the changes for QCOM platforms.

Regards,

Andy


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-fixes-for-4.13-rc2

for you to fetch changes up to 3ac8093cf5f7203140a3d8c28785d0d0dd89cd7c:

  arm64: defconfig: enable missing HWSPINLOCK (2017-07-27 23:09:54 -0500)

----------------------------------------------------------------
Qualcomm ARM64 based defconfig Fixes for v4.13-rc2

* Enable missing HWSPINLOCK

----------------------------------------------------------------
Georgi Djakov (1):
      arm64: defconfig: enable missing HWSPINLOCK

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
