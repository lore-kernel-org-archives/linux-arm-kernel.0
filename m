From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Mon, 16 Jul 2012 16:46:35 +0530
Subject: DT clock binding support build break
Message-ID: <5003F813.8090301@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

DT clock binding support patch breaks build when CONFIG_COMMON_CLK is 
not enabled.

/**
LD      init/built-in.o
drivers/built-in.o: In function `of_clk_get':
/home/ldewangan/upstreaming/july09/linux-next/drivers/clk/clkdev.c:42: 
undefined reference to `of_clk_get_from_provider'
make: *** [vmlinux] Error 1
**/

Any solution?

Thanks & Regards,
Prashant G
