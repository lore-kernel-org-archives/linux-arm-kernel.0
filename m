From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 14 May 2012 13:03:08 +0300
Subject: [PATCHv5 0/8] ARM: OMAP4: core retention support
Message-ID: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:

- Patch 6 now adds support for reading prev logic and mem states
  instead of tweaking the _update_logic_membank_counters function
  directly.

- Some version of "[PATCH] OMAP2+: UART: Add mechanism to probe uart
  pins and configure rx wakeup" from Govindraj is needed, otherwise
  UART can't wake up the device from suspend.

Tested with omap4460 GP panda + omap4430 EMU blaze devices.

Patches also available here:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-omap4-ret-v5

-Tero
