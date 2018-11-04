From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Nov 2018 22:37:39 +0800
Subject: [PATCH v2] ARM: dts: fsl: Fix improperly quoted stdout-path values
In-Reply-To: <20181031010230.6723-1-robh@kernel.org>
References: <20181031010230.6723-1-robh@kernel.org>
Message-ID: <20181104143738.GI26016@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 08:02:30PM -0500, Rob Herring wrote:
> A quoted label reference doesn't expand to the node path and is taken as
> a literal string. Dropping the quotes can fix this unless the baudrate
> string is appended in which case we have to use the alias.
> 
> At least on VF610, the problem was masked by setting the console in
> bootargs. Use the alias syntax with baudrate parameter so we can drop
> setting the console in bootargs.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks.
