From: davem@davemloft.net (David Miller)
Date: Fri, 23 Sep 2016 08:21:32 -0400 (EDT)
Subject: [PATCH net-next] drivers: net: xgene: Fix MSS programming
In-Reply-To: <1474584453-9071-1-git-send-email-isubramanian@apm.com>
References: <1474584453-9071-1-git-send-email-isubramanian@apm.com>
Message-ID: <20160923.082132.1550198525968986550.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Thu, 22 Sep 2016 15:47:33 -0700

> Current driver programs static value of MSS in hardware register for TSO
> offload engine to segment the TCP payload regardless the MSS value
> provided by network stack.
> 
> This patch fixes this by programming hardware registers with the
> stack provided MSS value.
> 
> Since the hardware has the limitation of having only 4 MSS registers,
> this patch uses reference count of mss values being used.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Signed-off-by: Toan Le <toanle@apm.com>

Applied.
