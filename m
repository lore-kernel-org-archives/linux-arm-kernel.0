From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  2 Oct 2015 15:20:55 -0700
Subject: [GIT PULL] Broadcom defconfig changes for v4.4
Message-ID: <1443824458-20799-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.4/defconfig

for you to fetch changes up to de0d542338bc507d2fc21bfca2be540f17fc874a:

  ARM: multi_v7_defconfig: Add NSP to defconfig (2015-09-14 16:15:08 -0700)

----------------------------------------------------------------
This pull request contains the following changes for the multi_v7_defconfig:

- Jon adds support for the NorthStar Plus SocS to the multi_v7_defconfig file

----------------------------------------------------------------
Jon Mason (1):
      ARM: multi_v7_defconfig: Add NSP to defconfig

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)
