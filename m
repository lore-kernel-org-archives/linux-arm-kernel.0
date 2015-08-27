From: davem@davemloft.net (David Miller)
Date: Thu, 27 Aug 2015 13:51:56 -0700 (PDT)
Subject: [PATCH v2 0/2] drivers: net: xgene: Add TSO support
In-Reply-To: <1440614886-23566-1-git-send-email-isubramanian@apm.com>
References: <1440614886-23566-1-git-send-email-isubramanian@apm.com>
Message-ID: <20150827.135156.661392666355549469.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Wed, 26 Aug 2015 11:48:04 -0700

> Adding TSO support for 10GbE
> 
> iperf Tx data rate without TSO: 3.42 Gbps
>                       with TSO: 9.41 Gbps
> 
> v2: Address review comments from v1
>     - skb_linearize() if headers doesn't fit in 3 hardware buffers
> 
> v1:
> * Initial version
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

Series applied, thanks.
