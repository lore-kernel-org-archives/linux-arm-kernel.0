From: davem@davemloft.net (David Miller)
Date: Sat, 24 Sep 2016 08:47:40 -0400 (EDT)
Subject: [PATCH v2 0/2] BQL support and fix for a regression issue
In-Reply-To: <1474621948-9172-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1474621948-9172-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20160924.084740.220729213459690389.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Fri, 23 Sep 2016 14:42:26 +0530

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> These patches add byte queue limit support and also fixes a regression
> issue introduced by commit
> 'net: thunderx: Use netdev's name for naming VF's interrupts'
> 
> Changes from v1:
> - As suggested added 'Fixes' tag with commit id of previous commit 
>   which cuased issue.
> - Also fixed the missing netdev_tx_reset_queue() function call in 
>   byte queue limits support patch.

Series applied to net-next, thanks.
