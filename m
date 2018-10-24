From: peda@axentia.se (Peter Rosin)
Date: Wed, 24 Oct 2018 13:43:59 +0000
Subject: [PATCH] ARM: dts: replace gpio-key,wakeup with wakeup-source
 property
In-Reply-To: <20181024114540.5196-1-sudeep.holla@arm.com>
References: <20181024114540.5196-1-sudeep.holla@arm.com>
Message-ID: <b81ade0b-2ec7-16a9-fb43-909008d96635@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-10-24 13:45, Sudeep Holla wrote:
> Most of the legacy "gpio-key,wakeup" and "enable-sdio-wakeup" boolean
> properties are already replaced with "wakeup-source". However few
> occurrences of old property has popped up again, probably from the
> remnants in downstream trees.
> 
> This patch replaces the legacy properties with the unified
> "wakeup-source" property.
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
