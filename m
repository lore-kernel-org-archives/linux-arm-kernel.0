From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 4 May 2014 21:03:44 -0400
Subject: [PATCH v2 08/12] ARM: marvell: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <1398925607-7482-9-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
 <1398925607-7482-9-git-send-email-computersforpeace@gmail.com>
Message-ID: <20140505010344.GE28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 11:26:43PM -0700, Brian Norris wrote:
> These defconfigs contain the CONFIG_M25P80 symbol, which is now
> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to satisfy
> the new dependency.
> 
> At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/configs/dove_defconfig     | 2 +-
>  arch/arm/configs/kirkwood_defconfig | 1 +
>  arch/arm/configs/mvebu_v5_defconfig | 1 +
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  4 files changed, 4 insertions(+), 1 deletion(-)

Applied to mvebu/defconfig with Ezequiel's Ack, and a reworded subject:

"ARM: mvebu: defconfig: add MTD_SPI_NOR (new dependency for M25P80)"

thx,

Jason.
