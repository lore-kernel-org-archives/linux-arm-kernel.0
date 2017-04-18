From: davem@davemloft.net (David Miller)
Date: Tue, 18 Apr 2017 15:55:24 -0400 (EDT)
Subject: [PATCH v2 net-next] drivers: net: xgene-v2: Extend ethtool
 statistics
In-Reply-To: <1492472875-32385-1-git-send-email-isubramanian@apm.com>
References: <1492472875-32385-1-git-send-email-isubramanian@apm.com>
Message-ID: <20170418.155524.509380512589251718.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 17 Apr 2017 16:47:55 -0700

> This patch adds extended statistics reporting to ethtool.
> 
> In summary, this patch,
> 
>    - adds ethtool.h with the statistics register definitions
>    - adds 'struct xge_gstrings_extd_stats' to gather extended stats
>    - modifies xge_get_strings(), get_sset_count() and
>      get_ethtool_stats() accordingly
>    - moves 'struct xge_gstrings_stats' to ethtool.h
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

Applied, thanks.
