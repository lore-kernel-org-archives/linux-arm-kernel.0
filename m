From: davem@davemloft.net (David Miller)
Date: Mon, 14 Mar 2016 12:33:55 -0400 (EDT)
Subject: [PATCH v2 0/2] net: thunderx: Performance enhancement changes
In-Reply-To: <1457953578-7054-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1457953578-7054-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20160314.123355.932808497910918919.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Mon, 14 Mar 2016 16:36:13 +0530

> Below patches attempts to improve performance by reducing
> no of atomic operations while allocating new receive buffers
> and reducing cache misses by adjusting nicvf structure elements.
> 
> Changes from v1:
>  No changes, resubmitting a fresh as per David's suggestion.

Series applied, thanks.
