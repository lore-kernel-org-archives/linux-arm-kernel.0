From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 21:05:30 +0800
Subject: [PATCH v2 3/3] ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup
 source
In-Reply-To: <20180517090552.5704-4-daniel@zonque.org>
References: <20180517090552.5704-1-daniel@zonque.org>
 <20180517090552.5704-4-daniel@zonque.org>
Message-ID: <20180520130528.GC26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 11:05:52AM +0200, Daniel Mack wrote:
> The touchscreen driver no longer configures the device as wakeup source by
> default. A "wakeup-source" property is needed.
> 
> To avoid regressions, this patch changes the DTS files for the only two
> users of this driver that didn't have this property yet.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>

Applied this one, thanks.
