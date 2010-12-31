From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat,  1 Jan 2011 00:59:23 +0100
Subject: [PATCH 0/2] New year's pxa fixes
Message-ID: <1293839965-3034-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First of all, happy new year !

Second, not even an hour after midnight (over here), here are some minor
fixes squishing some warnings in pxa tree.

Marek Vasut (2):
  pxa: Fix warning in zeus.c
  pxa: Remove unused variable in clock-pxa3xx.c

 arch/arm/mach-pxa/clock-pxa3xx.c |    1 -
 arch/arm/mach-pxa/zeus.c         |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
1.7.2.3
