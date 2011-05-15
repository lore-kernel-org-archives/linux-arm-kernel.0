From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Mon, 16 May 2011 00:45:56 +0300
Subject: [PATCHv2 0/2] [RFC] Shrink clock data utilizing preprocessor
Message-ID: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change shows a possibility to utilize C preprocessor to remove
redundant data from clock definitions for OMAP4 architecture.

If the change is evaluated as a positive one, the same approach could
be applied in reducing LOCs from other files, which contain monotonous
data enumeration.

Vladimir Zapolskiy (2):
  OMAP4: clock data: shrink clock data utilizing preprocessor.
  OMAP4: clock data: shrink more clock data.

 arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++-------------------------
 1 files changed, 848 insertions(+), 2465 deletions(-)

-- 
1.7.2.3
