From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Nov 2015 20:16:00 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151125183728.GO8644@n2100.arm.linux.org.uk>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151125160937.GJ14338@lunn.ch>
 <20151125183728.GO8644@n2100.arm.linux.org.uk>
Message-ID: <20151125191600.GM11384@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It feels today like I'm the only one working on improving Dove support,
> and so it's going to take a _long_ time to move things forward - it's
> likely to take years.  I have many demands on my time and I have to
> divide it up between the various aspects.

Hi Russell

The problem from our side is the apparent lack of progress. We get so
very few patches we wounder why we should keep it around. If there was
even a steady trick of patches, we would feel better about keeping it.

So looking at this list, could you maybe post the following, if they
don't have dependencies. Going from only the subject, most look simple
and should not be too much effort to get mainlined.

> orion clock build fix
> ARM: dove: more clock cleanups
> ARM: dove: cubox: add DT booting support

> ARM: dove: move hwmon initialisation into PMU driver

> ARM: l2c: tauros2: fix OF-enabled non-DT boot
> ARM: mvebu: allow mvebu/dove to be enabled

> ARM: cubox: fix flash type
> ARM: dove: remove cubox_extclk device
> ARM: dove: clock improvements
> ARM: dove: fix dove clock support to recalculate the actual rates
> ARM: dove: cleanup dove clock support
> ARM: dove: fix clock name
> ARM: dove: no need for empty clock enable/disable methods
> ARM: dove: remove unused clock declarations
> ARM: dove: fix 'addr' types in dove clock.c
> HWMON: dove: fix use if S_IRWXUGO in dove hwmon driver
> HWMON: move dove hwmon module to drivers/hwmon and add MODULE_ALIAS
> HWMON: dove: fix mask writes
> HWMON: dove: move current_mode and warning_flag into dovetemp_data
> HWMON: dove: push dovetemp_data down into functions
> HWMON: dove: move timer to dovetherm_data structure
> HWMON: dove: add driver private data
> HWMON: dove: use module_platform_driver in dove hwmon driver
> HWMON: dove: fix monitoring printks
> Revert "Allow ioremap_nocache on PJ4 processor that is in Dove."
> ARM: dove: convert legacy dove to PMU support
> dt-bindings: add Marvell PMU documentation
> of: Add vendor prefix for Vivante Corporation

  Andrew
