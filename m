From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 20 Nov 2014 23:48:55 +0100
Subject: [GIT PULL 1/2] ARM: berlin: SoC changes for v3.19 (round 2)
Message-ID: <1416523736-13504-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

I know it is late already but this is incremental Berlin SoC changes
for v3.19 (round 2). It basically only contains a fix to make
RESET_CONTROLLER user selectable again.

This PR is between tags/berlin-soc-3.19-1 and tags/berlin-soc-3.19-2,
I hope that is correct.

Please pull.

Thanks,
  Sebastian

The following changes since commit e9246c8726312aae36202b9e50c7e76a8609b712:

  ARM: Berlin: select the reset controller (2014-10-21 11:35:15 +0200)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-soc-3.19-2

for you to fetch changes up to 81906906d8d95837c87b934a1a929cc43b61f4ee:

  ARM: berlin: do not select RESET_CONTROLLER (2014-11-18 20:27:53 +0100)

----------------------------------------------------------------
Berlin SoC changes for v3.19 (round 2)
- Do not select RESET_CONTROLLER as it is user selectable

----------------------------------------------------------------
Antoine Tenart (1):
      ARM: berlin: do not select RESET_CONTROLLER

 arch/arm/mach-berlin/Kconfig | 1 -
 1 file changed, 1 deletion(-)
