From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 28 Aug 2017 17:43:14 +0800
Subject: [PATCH 2/2] clk: zte: constify clk_div_table
In-Reply-To: <1503898133-10862-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503898133-10862-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1503898133-10862-3-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20170828094313.GB3525@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 10:58:53AM +0530, Arvind Yadav wrote:
> clk_div_table are not supposed to change at runtime. All functions
> working with clk_div_table provided by <linux/clk-provider.h> work
> with const clk_div_table. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
