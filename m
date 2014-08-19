From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 20 Aug 2014 00:33:51 +0300
Subject: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not
 conflict with regulators
In-Reply-To: <20140819152405.GA12002@atomide.com>
References: <20140819152405.GA12002@atomide.com>
Message-ID: <20140819213351.GF4885@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 19, 2014 at 08:24:05AM -0700, Tony Lindgren wrote:
> Commit 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn
> off oscillator during off-idle) added support for configuring the PMIC
> to cut off resources during deeper idle states to save power.

[...]

> Fixes: 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle)
> Cc: stable at vger.kernel.org # v3.16
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
