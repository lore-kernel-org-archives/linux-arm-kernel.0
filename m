From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 24 Dec 2013 23:24:02 +0100
Subject: [PATCH 0/5] input: Add new sun4i-ts driver for Allwinner sunxi SoC's
Message-ID: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dimitri,

Here is a new driver for the resistive touchscreen controller found in
Allwinner sunxi SoC's. Please review, and when ready pull this driver into
your tree for Linus.

This series consist of 5 patches, the 1st patch is the actual new driver,
the 2nd patch extends it with support for the temperature sensor built into
the rtp controller. Since this depends on the 1st one I would like to ask
you to pull it into your tree too. I've written and maintain several hwmon
drivers, so I'm confident the hwmon bits are solid, I've also CC-ed the
sensors list so that they can review and if they've any comments I will of
course fix those and send a new version.

Patch 3-5 are dts patches adding the controller to the dts files describing
the sunxi SoC variants. These will be merged through Maxime Ripard's tree,
and are here so that the dts bits can be reviewed at the same time. I'll ask
Maxime to merge them once you're happy with Patch 1 + 2.

Thanks & Regards,

Hans
