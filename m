From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 11:29:49 -0500
Subject: [PATCH] arm: mvebu: enable the SD card slot on Armada 370
 Reference Design board
In-Reply-To: <1359715108-13982-1-git-send-email-florian@openwrt.org>
References: <20130131175743.GF7717@titan.lakedaemon.net>
 <1359715108-13982-1-git-send-email-florian@openwrt.org>
Message-ID: <20130216162949.GA14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 11:38:28AM +0100, Florian Fainelli wrote:
> The Armada 370 Reference Design board has one SD card slot, directly
> connected to the SDIO IP of the SoC, so we enable this IP. there are no
> GPIOs for card-detect and write-protect so we do not specify any.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Jason,
> 
> This is against your mvebu/dt branch
> 
>  arch/arm/boot/dts/armada-370-rd.dts |    7 +++++++
>  1 file changed, 7 insertions(+)

Applied to mvebu/dt

thx,

Jason.
