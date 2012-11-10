From: mturquette@ti.com (Mike Turquette)
Date: Fri, 9 Nov 2012 17:44:37 -0800
Subject: [PATCH 0/2] clk: ux500: Add some more clk lookups for u8500
In-Reply-To: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
References: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121110014437.16569.40581@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2012-10-31 06:40:51)
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Some more clock lookups added for rng clocks and for the nomadik ske
> keypad clocks.
> 

Taken into clk-next.

Thanks,
Mike

> Ulf Hansson (2):
>   clk: ux500: Register rng clock lookups for u8500
>   clk: ux500: Register nomadik keypad clock lookups for u8500
> 
>  drivers/clk/ux500/u8500_clk.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> -- 
> 1.7.10
