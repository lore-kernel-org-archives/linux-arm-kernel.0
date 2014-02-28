From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 28 Feb 2014 11:22:52 +0200
Subject: [PATCH 00/12] ARM: OMAP2 DT clock conversion
Message-ID: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set concludes the omap2+ clock DT conversion work by creating the
DT clock data for omap2 SoC also.

I am also currently doing related work to cleanup CM/PRM codebase in
preparation to move it into drivers/, this set is basically going to
be a pre-requisite for that. I'll hopefully post something related
to that early next week.

This set has been boot tested on OMAP2430 only (thanks Nishanth, I don't
have access to OMAP2 hardware myself), so any testing feedback on
2420 board(s) would be appreciated.

Working tree:

Tree: https://github.com/t-kristo/linux-pm.git
Branch: 3.14-rc4-omap2-dt-clks

-Tero
