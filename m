From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 7 Oct 2013 19:53:29 +0530
Subject: [PATCH V2] clk: palmas: add clock driver for palmas
In-Reply-To: <1381154751-4565-1-git-send-email-ldewangan@nvidia.com>
References: <1381154751-4565-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <5252C3E1.5010509@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 October 2013 07:35 PM, Laxman Dewangan wrote:
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -43,3 +43,5 @@ obj-$(CONFIG_COMMON_CLK_SI5351) += clk-si5351.o
>   obj-$(CONFIG_COMMON_CLK_S2MPS11) += clk-s2mps11.o
>   obj-$(CONFIG_CLK_TWL6040)	+= clk-twl6040.o
>   obj-$(CONFIG_CLK_PPC_CORENET)	+= clk-ppc-corenet.o
> +obj-$(CONFIG_COMMON_CLK_PALMAS)	+= clk-palmas.o
> +obj-y += clk-test.o
>

Sorry, silly mistake, the line

+obj-y += clk-test.o

is not require. This was done for testing only.

I will respin the patch but wait for some more feedback if any to add on 
next version.

Thanks,
Laxman
