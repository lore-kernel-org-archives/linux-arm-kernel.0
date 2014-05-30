From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 30 May 2014 16:25:14 +0800
Subject: [PATCH 1/2] ARM: i.MX: Use of_clk_get_by_name() for timer clocks
 for DT case.
In-Reply-To: <1401181487-25828-1-git-send-email-shc_work@mail.ru>
References: <1401181487-25828-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140530082511.GJ8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 01:04:46PM +0400, Alexander Shiyan wrote:
> Use of_clk_get_by_name() for timer clocks for DT case.
> This patch eliminates a lot of unneeded clk_register_clkdev()
> calls for GPT.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied both, thanks.
