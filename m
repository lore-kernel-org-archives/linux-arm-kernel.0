From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 May 2014 11:08:06 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Zynq peripheral drivers
In-Reply-To: <1401210268-20729-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1401210268-20729-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140527180806.GA26308@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 10:04:28AM -0700, Soren Brinkmann wrote:
> A few drivers for Zynq peripherals made it into mainline recently.
> Enable them in the defconfig. The following devices are enabled:
>  - Cadence Macb Ethernet controller
>  - Cadence I2C controller
>  - Arasan SDHCI
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> After quite a while I gave the defonfig a shot again. At first try it
> directly booted my Zynq board to a usable login prompt, and with this
> patch even some peripherals work out of the box.

Applied, thanks!


-Olof
