From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 25 Mar 2013 18:26:34 +0900
Subject: [PATCH v2 0/4] clk: samsung: pm fixes and multiple aliases
In-Reply-To: <201303131458.18671.heiko@sntech.de>
References: <201303131458.18671.heiko@sntech.de>
Message-ID: <176601ce293a$d7a0e190$86e2a4b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Second version of the fixes to address comments gathered from the first
> version, like not entering the dt code on non-dt platforms even if
> dt-support is present in the kernel.
> 
> Patch 1 and 3 got "Reviewed-by" tags but I only included the one for
> patch 1, because patch 3 changed due to the changes in patch 2.
> 
> Heiko Stuebner (4):
>   clk: samsung: register clk_div_tables for divider clocks
>   clk: samsung: fix pm init on non-dt platforms
>   clk: samsung: always allocate the clk_table
>   clk: samsung: add infrastructure to add separate aliases
> 
>  drivers/clk/samsung/clk.c |   72 +++++++++++++++++++++++++++++++++++------
> ---
>  drivers/clk/samsung/clk.h |   34 ++++++++++++++++++--
>  2 files changed, 87 insertions(+), 19 deletions(-)
> 
> --
> 1.7.2.3

Looks good to me and applied into samsung tree based on samsung common clock by Thomas P Abraham for testing.

But would be helpful to me if I could get Mike's ack on this series.

Thanks.

- Kukjin
