From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Sep 2011 16:12:08 -0700
Subject: [PATCH 08/11] OMAP2+: board-generic: Add i2c static init
In-Reply-To: <1316809399-19579-9-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
	<1316809399-19579-9-git-send-email-b-cousson@ti.com>
Message-ID: <20110923231208.GE6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> Still needed to boot until the i2c & twl driver is adapted to
> device-tree. Otherwise the voltage control code will try to
> access the twl and crash.

That sounds OK to me for now. For merging these patches, how
about the following:

- Kevin queues up the omap_device related changes

- Grant queues up the .dts changes

- I'll queue the map_io and board changes based on Kevin's
  omap_device changes

Regards,

Tony
