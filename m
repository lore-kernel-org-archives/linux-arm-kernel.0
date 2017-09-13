From: davem@davemloft.net (David Miller)
Date: Tue, 12 Sep 2017 20:59:47 -0700 (PDT)
Subject: [PATCH] w90p910_ether: include linux/interrupt.h
In-Reply-To: <20170912123227.3418786-1-arnd@arndb.de>
References: <20170912123227.3418786-1-arnd@arndb.de>
Message-ID: <20170912.205947.2162006850051360659.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 12 Sep 2017 14:31:48 +0200

> A randconfig build caused a compile failure:
> 
> drivers/net/ethernet/nuvoton/w90p910_ether.c: In function 'w90p910_ether_close':
> drivers/net/ethernet/nuvoton/w90p910_ether.c:580:2: error: implicit declaration of function 'free_irq'; did you mean 'free_uid'? [-Werror=implicit-function-declaration]
> 
> Adding the correct include fixes the problem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
