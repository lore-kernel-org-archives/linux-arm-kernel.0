From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 19 Oct 2011 11:39:16 +0200
Subject: [PATCH 0/4] ARM: OMAP3: cm-t35/cm-t3730 fixes
Message-ID: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes several issues on boards in subj.
It is based on Tony's board branch at [1].

[1] git://github.com/tmlind/linux.git


Igor Grinberg (4):
  ARM: OMAP3: cm-t35: add regulator supply for ads7846
  ARM: OMAP3: cm-t35: fix DSS regulator supply
  ARM: OMAP3: cm-t35: fix audio
  arm: omap3: cm-t35: add reset for sb-t35 usb hub

 arch/arm/mach-omap2/board-cm-t35.c |   50 ++++++++++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 10 deletions(-)

-- 
1.7.3.4
