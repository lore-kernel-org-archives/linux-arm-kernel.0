From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jun 2014 14:51:56 +0800
Subject: [PATCH 2/2] ARM: i.MX25 clk: Use of_clk_init() for DT case
In-Reply-To: <1402664146-14314-2-git-send-email-denis@eukrea.com>
References: <1402664146-14314-1-git-send-email-denis@eukrea.com>
 <1402664146-14314-2-git-send-email-denis@eukrea.com>
Message-ID: <20140621065155.GF6818@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 02:55:46PM +0200, Denis Carikli wrote:
> Replace .init_time() hook with of_clk_init() for DT targets.
> 
> Based on:
>   d4347ee ARM: i.MX27 clk: Use of_clk_init() for DT case
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>

The patch does not apply on my branch.  Can you please rebase it on my
for-next branch?

Shawn
