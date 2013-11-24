From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 22:26:06 -0500
Subject: [PATCH] clk: mvebu: staticize of_cpu_clk_setup
In-Reply-To: <1383814773-5231-1-git-send-email-jszhang@marvell.com>
References: <1383814773-5231-1-git-send-email-jszhang@marvell.com>
Message-ID: <20131124032606.GU29241@titan.lakedaemon.net>
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

Applied to mvebu/clk with Gregory and my Acks destined for the clock
tree.

thx,

Jason.
