From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun,  6 Nov 2011 16:13:47 +0200
Subject: [PATCH v2 0/4] ARM: OMAP3: cm-t35/cm-t3730 fixes
In-Reply-To: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes several issues on boards in subj.
It is based on Tony's fixes branch.

v2:	- Rebase on top of fixes branch
	- Elaborate more in the commit messages

Igor Grinberg (4):
  ARM: OMAP3: cm-t35: fix ads7846 touchscreen
  ARM: OMAP3: cm-t35: fix DSS regulator supply
  ARM: OMAP3: cm-t35: fix audio
  ARM: OMAP3: cm-t35: fix USB hub

 arch/arm/mach-omap2/board-cm-t35.c |   50 ++++++++++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 10 deletions(-)

-- 
1.7.3.4
