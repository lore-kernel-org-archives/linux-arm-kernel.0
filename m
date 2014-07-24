From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Jul 2014 20:46:31 +0200
Subject: [PATCH 0/2] ARM: Marvell Armada XP datasheet publicly available
Message-ID: <1406227593-29749-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of two patches make a few updates to the README file of
the kernel documentation related to Marvell ARM platforms in the
kernel.

The most important announcement is the public release by Marvell of
the datasheet for the Armada XP SoC. It follows the publication, a few
weeks ago, of the Armada 370 datasheet.

The second patch makes a few other updates to the same documentation,
taking into account recent movements in the support for Marvell SoCs
in the kernel.

The series is based on top of Jason's mvebu/soc branch.

Thanks,

Thomas

Thomas Petazzoni (2):
  Documentation: arm: add URLs to public datasheets for the Marvell
    Armada XP SoC
  Documentation: arm: misc updates to Marvell EBU SoC status

 Documentation/arm/Marvell/README | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.0.0
