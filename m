From: sw.youn@samsung.com (Seungwhan Youn)
Date: Fri, 24 Dec 2010 15:26:05 +0900
Subject: [PATCH 0/4] Modify configures to support Samsung ASoC dependancyless
Message-ID: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches modify configuration to make audio support configurations on
platform(or arch) from sound/soc/samsung. This prevents that audio config
consider which board(or arch) can(or should) support ASoC audio driver, and
also prevents audio config dependancy on future Samsung SoCs.


These patches are modify below features:-
 o Add audio configurations on plat(or arch).
 o Modify audio configuration depends on plat(or arch) selection on ASoC.

This patch-set is based on two different branches that :-
 o ARM patches are based on Kukjin Kim's git branch 'for-next'
   (commit id - 30fb9a94ec22435add3d2ea2d1b01c1a5ad6164c)
 o ASoC patches are based on Mark Brown's git branch 'for-next'
   (commit id - 722bc28384accb67c0bfbbe1914fd82d4d0c996a)

This patch-set contains followings :-
 o To Kukjin Kim, Ben Dooks and Russell King,
  - [PATCH 1/4] ARM: Kconfig: Add audio support dependency
  - [PATCH 2/4] ARM: SAMSUNG: Add SMDK audio configuration
 o To Jassi Brar, Mark Brown and Liam Girdwood,
  - [PATCH 3/4] ASoC: SAMSUNG: Modify to indepedant depends on configuration
  - [PATCH 4/4] ASoC: SAMSUNG: Apply modifications for SMDK audio configuations


Marry X-mas,
Claude(Seungwhan Youn)
