From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 24 Feb 2012 17:15:40 +0200
Subject: [PATCHv2 0/6] ARM: OMAP4 core retention support
Message-ID: <1330096546-20477-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes compared to previous version:

- patch2: changed timeout value to 100us (from 1000us)
- patch2: added timeout after the WUCLKIN disable
- some cosmetic tweaking to other patches

Tested on omap4430 blaze board with EMU chip, suspend / resume ok.

-Tero
