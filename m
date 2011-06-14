From: linux_arm@lakedaemon.net (linux_arm at lakedaemon.net)
Date: Tue, 14 Jun 2011 19:52:53 +0000
Subject: [PATCH 0/2 RFC] arm/kirkwood: add dreamplug support.
Message-ID: <cover.1308080024.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Cooper <linux_arm@lakedaemon.net>

All,

This is an RFC patch series until mach-types is updated.  This compiles,
loads, runs, and sees the SPI flash.

Concerns:

	- I sent an email to rmk a day or two ago regarding updating the
	  mach-types, but haven't heard.  I know he's busy, just wanted
	  to make sure I was doing it right.  I requested it here [1].

	- I haven't had a chance to confirm the LED mappings are correct.

	- Once the mach-types are updated, I'll drop the first patch, it's
	  just for folks who want to try the series and have it build and run.

[1] http://www.arm.linux.org.uk/developer/machines/list.php?id=3550

Jason Cooper (2):
  arm/kirkwood: TEMP hack till mach-types is updated.
  arm/kirkwood: add dreamplug support.

 arch/arm/mach-kirkwood/Kconfig           |    6 ++
 arch/arm/mach-kirkwood/Makefile          |    1 +
 arch/arm/mach-kirkwood/dreamplug-setup.c |  144 ++++++++++++++++++++++++++++++
 arch/arm/tools/mach-types                |    1 +
 4 files changed, 152 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/dreamplug-setup.c
