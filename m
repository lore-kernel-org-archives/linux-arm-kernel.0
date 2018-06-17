From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 17 Jun 2018 15:15:51 +0800
Subject: [PATCH v2] ARM: dts: imx51-zii-rdu1: Make sure SD1_WP is low
In-Reply-To: <20180526021238.30753-1-andrew.smirnov@gmail.com>
References: <20180526021238.30753-1-andrew.smirnov@gmail.com>
Message-ID: <20180617071550.GN16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 07:12:38PM -0700, Andrey Smirnov wrote:
> Make sure that MX51_PAD_GPIO1_1 does not remain configure as
> ALT0/SD1_WP (it is out of reset). This is needed because of external
> pull-up resistor attached to that pad that, when left unchanged, will
> drive SD1_WP high preventing eSDHC1/eMMC from working correctly.
> 
> To fix that add a pinmux configuration line configureing the pad to
> function as a GPIO. While we are at it, add a corresponding
> output-high GPIO hog in an effort to minimize current consumption.
> 
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied, thanks.
