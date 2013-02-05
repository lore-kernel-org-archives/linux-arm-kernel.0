From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Feb 2013 07:23:21 -0500
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130205122320.GR14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 08:24:33AM -0300, Ezequiel Garcia wrote:
> This patch adds an SPI master device node for Armada XP-GP board.
> This master node is an SPI flash controller 'n25q128a13'.
> 
> Since there is no 'partitions' node declared, one full sized
> partition named as the device will be created.
> 
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> This patch depends on:
> 
>  1. Gregory's patch for Armada XP GP board:
>       arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)
> 
>  2. My previous patch for SPI on Armada 370/XP:
>       arm: mvebu: Add support for SPI controller in Armada 370/XP
> 
> And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y
> 
>  arch/arm/boot/dts/armada-xp-gp.dts |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)

Very nice, thanks for listing the dependencies.  That makes things a lot
easier on this end.

thx,

Jason.
