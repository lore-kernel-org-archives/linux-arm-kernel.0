From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Mar 2011 15:28:13 -0700
Subject: [PATCH 3 00/18] I2C: OMAP1: OMAP2+: I2C fixes, removal of
	cpu_is... from driver
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Message-ID: <20110315222813.GL7258@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Andy Green <andy@warmcat.com> [110315 12:53]:
> The following series removes cpu_...() usage completely from the
> omap-i2c driver by having decisions about functional implementation
> choices in the SoC held in cpu-specific hwmod tables that are
> already established, or for OMAP1 where there is no hwmod, set at
> OMAP1-specific i2c bus addition time.

You should send this to the i2c list with Ben Cc'd.

Tony
