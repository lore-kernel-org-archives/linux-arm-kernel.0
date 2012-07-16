From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 09:19:45 -0500
Subject: DT clock binding support build break
In-Reply-To: <5003F6DF.2010107@nvidia.com>
References: <5003F6DF.2010107@nvidia.com>
Message-ID: <50042301.6000108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2012 06:11 AM, Prashant Gaikwad wrote:
> Hi Rob,
> 
> DT clock binding support patch breaks build when CONFIG_COMMON_CLK is
> not enabled.
> 
> /**
> LD      init/built-in.o
> drivers/built-in.o: In function `of_clk_get':
> /home/ldewangan/upstreaming/july09/linux-next/drivers/clk/clkdev.c:42: undefined reference to `of_clk_get_from_provider'
> make: *** [vmlinux] Error 1
> **/
> 
> Any solution?

I'll get a fix out today.

Rob

> 
> Thanks & Regards,
> Prashant G
