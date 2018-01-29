From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Jan 2018 16:25:43 +0800
Subject: [PATCH v3] ARM: dts: imx6: RDU2: disable internal watchdog
In-Reply-To: <20180103193237.15716-1-andrew.smirnov@gmail.com>
References: <20180103193237.15716-1-andrew.smirnov@gmail.com>
Message-ID: <20180129082541.GD26461@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 11:32:37AM -0800, Andrey Smirnov wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The system has an external watchdog in the environment processor
> so the internal watchdog is of no use.
> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: cphealy at gmail.com
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied, thanks.
