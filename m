From: davem@davemloft.net (David Miller)
Date: Fri, 13 May 2016 21:12:26 -0400 (EDT)
Subject: [PATCH v2 0/5] drivers: net: xgene: Bug fixes
In-Reply-To: <1463183581-30475-1-git-send-email-isubramanian@apm.com>
References: <1463183581-30475-1-git-send-email-isubramanian@apm.com>
Message-ID: <20160513.211226.1164377917890147208.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Fri, 13 May 2016 16:52:56 -0700

> This patch set addresses the following bug fixes that were found during testing.
> 
>   1. IPv4 forward test crash
>     - drivers: net: xgene: fix IPv4 forward crash
> 
>   2. Sharing of irqs
>     - drivers: net: xgene: fix sharing of irqs
> 
>   3. Ununiform latency across queues
>     - drivers: net: xgene: fix ununiform latency across queues
> 
>   4. Fix statistics counters race condition
>     - drivers: net: xgene: fix statistics counters race condition
> 
>   5. Correcting register offset and field lengths
>     - drivers: net: xgene: fix register offset
> 
> v2: Address review comments from v1
> - Defer TSO fix, and reposting all other patches from v1
> 
> v1:
> - Initial version
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

Series applied, thanks.
