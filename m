From: davem@davemloft.net (David Miller)
Date: Wed, 31 Aug 2016 20:46:33 -0700 (PDT)
Subject: [PATCH 5/5] net: axienet: constify ethtool_ops structures
In-Reply-To: <1472682083-5219-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1472682083-5219-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472682083-5219-6-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160831.204633.1599084771774333347.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu,  1 Sep 2016 00:21:23 +0200

> Check for ethtool_ops structures that are only stored in the ethtool_ops
> field of a net_device structure or passed as the second argument to
> netdev_set_default_ethtool_ops.  These contexts are declared const, so
> ethtool_ops structures that have these properties can be declared as const
> also.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
 ...
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.
