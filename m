From: davem@davemloft.net (David Miller)
Date: Wed, 31 Aug 2016 20:46:11 -0700 (PDT)
Subject: [PATCH 1/5] net: mediatek: constify ethtool_ops structures
In-Reply-To: <1472682083-5219-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1472682083-5219-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472682083-5219-2-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160831.204611.1055073690254982380.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu,  1 Sep 2016 00:21:19 +0200

> Check for ethtool_ops structures that are only stored in the ethtool_ops
> field of a net_device structure or passed as the second argument to
> netdev_set_default_ethtool_ops.  These contexts are declared const, so
> ethtool_ops structures that have these properties can be declared as const
> also.
 ...
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.
