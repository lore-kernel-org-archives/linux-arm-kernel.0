From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jul 2018 13:45:48 +0800
Subject: [PATCH 2/2] ARM: dts: imx51-babbage: Make use of pinctrl_usbh1reg
In-Reply-To: <20180628043713.14425-2-andrew.smirnov@gmail.com>
References: <20180628043713.14425-1-andrew.smirnov@gmail.com>
 <20180628043713.14425-2-andrew.smirnov@gmail.com>
Message-ID: <20180703054547.GD4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 09:37:13PM -0700, Andrey Smirnov wrote:
> Pinctrl_usbh1reg defines pinmux setting for reset GPIO used by
> usbh1phy, but is not referenced by that node. Fix that.
> 
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied, thanks.
