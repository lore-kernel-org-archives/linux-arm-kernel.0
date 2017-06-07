From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 7 Jun 2017 11:37:07 +0800
Subject: [PATCH] ARM: dts: imx6: Fix PCI GPIO reset polarity
In-Reply-To: <1496679740-1426-1-git-send-email-festevam@gmail.com>
References: <1496679740-1426-1-git-send-email-festevam@gmail.com>
Message-ID: <20170607033706.GC31070@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 01:22:20PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The imx6 PCI driver ignores the GPIO polarity from 'reset-gpio' and
> considers that the PCI reset is active low, unless the
> property 'reset-gpio-active-high' is present.
> 
> Fix the device tree description by explicitly passing the 
> 'GPIO_ACTIVE_LOW' flag to the 'reset-gpio' property.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
