From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 19:05:31 +0300
Subject: [PATCHv6 00/11]: ARM: OMAP: PM usecounting changes
Message-ID: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:

- Added patch #1 for fixing a potential race condition within clockdomain
  code
- Fixed patch #3 (old patch #2) regarding a similar race condition within
  the voltagedomain code

Tested with OMAP3 beagle, OMAP4460 GP panda, OMAP4430 EMU blaze devices.

Branch available:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.6-rc5-pwrdm-changes-v6

-Tero
