From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 21 Jun 2017 18:42:32 +0200
Subject: [GIT PULL] pxa-dt for v4.13
Message-ID: <87wp85mgw7.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.13 device-tree, with only a small unitary
patch from Viresh.

Can you please consider pulling ?

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.13

for you to fetch changes up to a87027196803227dd9f4ee848f4aa2dbfe699c4c:

  ARM: pxa: Use - instead of @ for DT OPP entries (2017-06-21 14:09:52 +0200)

----------------------------------------------------------------
This device-tree pxa update brings :
 - cpu operating points renaming from Viresh

----------------------------------------------------------------
Viresh Kumar (1):
      ARM: pxa: Use - instead of @ for DT OPP entries

 arch/arm/boot/dts/pxa25x.dtsi |  8 ++++----
 arch/arm/boot/dts/pxa27x.dtsi | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

-- 
Robert
