From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 26 May 2018 19:37:37 +0100
Subject: [GIT PULL v2] arm64: hisilicon fixes for 4.17
Message-ID: <5B09A971.6030506@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please help to pull the following fix.
Sorry for the late fix pull since we just got the patch.
And if the pull is too late, I will rebase the patch after 4.18-rc1 released.
Thanks!

Best Regards,
Wei

---

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-4.17v2

for you to fetch changes up to 9c6d26df1fae6ad4718d51c48e6517913304ed27:

  arm64: dts: hikey: Fix eMMC corruption regression (2018-05-26 17:51:47 +0100)

----------------------------------------------------------------
ARM64: hisi fixes for 4.17

- Remove eMMC max-frequency property to fix eMMC corruption on hikey board

----------------------------------------------------------------
John Stultz (1):
      arm64: dts: hikey: Fix eMMC corruption regression

 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
 1 file changed, 1 deletion(-)
