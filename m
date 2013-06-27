From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 27 Jun 2013 11:38:15 +0300
Subject: [PATCH 0/4] ARM: OMAP5 and DRA7 clock data
Message-ID: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches provide clock data for TI OMAP5 and DRA7 SoCs. Clock data
is mostly in device tree format, and only a small init portion is needed
under mach-omap2. These patches come on top of the base OMAP4 clock data
conversion I posted earlier this week:

  http://comments.gmane.org/gmane.linux.ports.arm.omap/100117

These patches need the basic SoC boot support before they are of any use.

Boot tested with private tree and compile tested against 3.10-rc6.

-Tero
