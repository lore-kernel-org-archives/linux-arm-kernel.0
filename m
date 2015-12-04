From: davem@davemloft.net (David Miller)
Date: Fri, 04 Dec 2015 15:01:37 -0500 (EST)
Subject: [PATCH net 0/3] Marvell Armada 375 mvpp2 fixes
In-Reply-To: <1449152451-2939-1-git-send-email-mw@semihalf.com>
References: <1449152451-2939-1-git-send-email-mw@semihalf.com>
Message-ID: <20151204.150137.97964032407636739.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Thu,  3 Dec 2015 15:20:48 +0100

> During my work on mvneta driver I revised mvpp2, and it occurred that the
> initial version of Marvell Armada 375 SoC comprised bugs around
> DMA-unmapping in both ingress and egress paths - not all buffers were
> umapped in TX path and none(!) in RX. Three patches that I send fix
> this situation.
> 
> Any feedback would be welcome.

Series applied, thank you.
