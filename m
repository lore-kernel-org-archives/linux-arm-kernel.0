From: davem@davemloft.net (David Miller)
Date: Wed, 01 Oct 2014 15:01:33 -0400 (EDT)
Subject: [PATCH v2] net: ll_temac: Remove unnecessary ether_setup after
 alloc_etherdev
In-Reply-To: <909ad6e2f067c956a2bb89d848a2fc38fc605a08.1412154072.git.michal.simek@xilinx.com>
References: <909ad6e2f067c956a2bb89d848a2fc38fc605a08.1412154072.git.michal.simek@xilinx.com>
Message-ID: <20141001.150133.82852657000649592.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Simek <michal.simek@xilinx.com>
Date: Wed,  1 Oct 2014 11:01:17 +0200

> From: Subbaraya Sundeep Bhatta <subbaraya.sundeep.bhatta@xilinx.com>
> 
> Calling ether_setup is redundant since alloc_etherdev calls it.
> 
> Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Remove axienet because it is already applied in separate patch
>   https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=c706471b2601d1c9058e7b866db77f6eb7dd37af

Applied, thanks Michal.
