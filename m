From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 18 May 2017 20:16:09 +0300
Subject: [PATCHv3 0/3] ARM: OMAP2+: preparation for clk/clkctrl support
Message-ID: <1495127772-7486-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series contains a couple of fixes for supporting clkctrl driver
for OMAP4. The patches in this series can be applied separately,
they don't have any dependency towards the clock driver related patches.
Once the clockctrl driver support itself [1] and this series have
been applied, the DTS changes can start flowing in.

Reference branch with the clkctrl driver, this series and
preliminary DTS patches pushed here:

Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.12-rc1-clkctrl-integ

Tested the integrated branch with omap4 boot, suspend-resume, and
also with the HDMI external display test (this was failing with some
older revision of the series.)

-Tero

[1] https://www.spinics.net/lists/arm-kernel/msg581685.html
