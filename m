From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 1 May 2014 14:53:28 -0300
Subject: [PATCH v2 08/12] ARM: marvell: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <1398925607-7482-9-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
 <1398925607-7482-9-git-send-email-computersforpeace@gmail.com>
Message-ID: <20140501175328.GA22786@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 30, Brian Norris wrote:
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

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

And tested the SPI is now selected (and works on Armada XP GP)
using mvebu_v7_defconfig.

Thanks a lot for taking care of this,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
