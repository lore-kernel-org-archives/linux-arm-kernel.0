From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 4 Jul 2014 17:10:25 +0300
Subject: [PATCH 00/10] ARM: OMAP2+: PRCM cleanup series for 3.17
Message-ID: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here's a small PRCM cleanup series against 3.16-rc1, meant for 3.17
if at all possible. Basically some cleanup to remove the direct CM/PRM
register accesses outside PRCM drivers. This set is touching the OMAP2/
OMAP3 code only. This series is part of the ongoing work to make PRCM
a separate driver.

Testing done:
- omap2430-sdp : boot
- omap3-beagle : boot, suspend/resume (ret), suspend/resume (off)

Working branch:
- tree: https://github.com/t-kristo/linux-pm.git
- branch: for-v3.17/cm-prm-cleanup

-Tero
