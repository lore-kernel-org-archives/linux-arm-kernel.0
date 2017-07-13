From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 13 Jul 2017 16:42:18 +0800
Subject: [PATCH 2/2] ARM: dts: imx7d-sdb: Pass 'enable-gpios' and
 'power-supply'
In-Reply-To: <1499865500-8857-2-git-send-email-marco.franchi@nxp.com>
References: <1499865500-8857-1-git-send-email-marco.franchi@nxp.com>
 <1499865500-8857-2-git-send-email-marco.franchi@nxp.com>
Message-ID: <20170713084216.GU3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 10:18:20AM -0300, Marco Franchi wrote:
> Currently the LCD is turned on thanks to the bootloader initialization.
> 
> In order to make the kernel to turn on the LCD on is own, pass the 
> 'enable-gpios' and 'power-supply' properties.
> 
> Also, the GPIO1_IO01 is not used as PWM functionality on this board. It is 
> connected to the PWREN pin of connector J14 and has a GPIO function, so remove 
> the PWM1 node and change the GPIO1_IO01 IOMUX to GPIO function.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

It doesn't apply to imx/dt.  Please rebase.

Shawn
