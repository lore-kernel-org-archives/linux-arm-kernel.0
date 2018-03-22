From: davem@davemloft.net (David Miller)
Date: Thu, 22 Mar 2018 15:07:46 -0400 (EDT)
Subject: [RFC PATCH] net: stmmac: dwmac-sun8i: sun8i_syscon_reg_field
 can be static
In-Reply-To: <20180322074217.GA7358@ivytown2.lkp.intel.com>
References: <20180317092857.4396-7-wens@csie.org>
 <20180322074217.GA7358@ivytown2.lkp.intel.com>
Message-ID: <20180322.150746.1491738155292875468.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: kbuild test robot <lkp@intel.com>
Date: Thu, 22 Mar 2018 15:42:18 +0800

> 
> Fixes: e3c10deef23c ("net: stmmac: dwmac-sun8i: Use regmap_field for syscon register access")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

This commit ID and this symbol are both not present in any of my trees.

Please avoid using SHA1 IDs which don't actually exist in an upstream
tree.  When I see a "Fixes: " tag like this, I expect that it is for a
change in my tree.
