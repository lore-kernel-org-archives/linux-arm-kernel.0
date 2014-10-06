From: davem@davemloft.net (David Miller)
Date: Sun, 05 Oct 2014 21:19:16 -0400 (EDT)
Subject: [PATCH RESEND] net: pxa168_eth: avoid using signed char for bitops
In-Reply-To: <1412348899-20586-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1412348899-20586-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20141005.211916.2141017785429102158.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>
Date: Fri,  3 Oct 2014 17:08:19 +0200

> Signedness bugs may occur when using signed char for bitops,
> depending on if the highest bit is ever used.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.
