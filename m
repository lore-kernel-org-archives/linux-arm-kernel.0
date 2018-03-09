From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 9 Mar 2018 15:42:31 +0000
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.17
Message-ID: <5AA2AB67.7070106@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.17

for you to fetch changes up to 5fc990703e8663b00741f6f86990d33093510302:

  arm64: defconfig: enable IOSCHED_DEADLINE (2018-03-02 15:35:34 +0000)

----------------------------------------------------------------
ARM64: hisilicon: defconfig updates for 4.17

- Enable deadline IO scheduler to improve the performnace for some
usecaese without changing the default IO scheduler

----------------------------------------------------------------
John Garry (1):
      arm64: defconfig: enable IOSCHED_DEADLINE

 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)
