From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 9 Jun 2014 11:15:48 +0800
Subject: [PATCH 1/2] ARM: i.MX27 clk: Separate DT and non-DT init procedure
In-Reply-To: <1402157366-25134-1-git-send-email-shc_work@mail.ru>
References: <1402157366-25134-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140609031547.GZ8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 07, 2014 at 08:09:25PM +0400, Alexander Shiyan wrote:
> This patch separates DT and non-DT clock initialization procedure,
> so we can avoid a lot of unneeded clk_register_clkdev() for DT case.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied both, thanks.
