From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 7 Nov 2013 06:47:14 -0500
Subject: [PATCH] clk: mvebu: staticize of_cpu_clk_setup
In-Reply-To: <1383814773-5231-1-git-send-email-jszhang@marvell.com>
References: <1383814773-5231-1-git-send-email-jszhang@marvell.com>
Message-ID: <20131107114714.GI8308@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 04:59:33PM +0800, Jisheng Zhang wrote:
> This symbol is used only in this file. The patch fix the following
> sparse warning:
> warning: symbol 'of_cpu_clk_setup' was not declared. Should it be static?
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/clk/mvebu/clk-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
