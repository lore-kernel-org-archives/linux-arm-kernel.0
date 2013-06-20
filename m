From: davem@davemloft.net (David Miller)
Date: Wed, 19 Jun 2013 23:05:46 -0700 (PDT)
Subject: [PATCH 2/9] PTR_RET is now PTR_ERR_OR_ZERO(): Replace most.
In-Reply-To: <1371357768-4968-2-git-send-email-rusty@rustcorp.com.au>
References: <87ehc2rczo.fsf@rustcorp.com.au>
 <1371357768-4968-1-git-send-email-rusty@rustcorp.com.au>
 <1371357768-4968-2-git-send-email-rusty@rustcorp.com.au>
Message-ID: <20130619.230546.1612893804152231671.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Sun, 16 Jun 2013 14:12:41 +0930

> Sweep of the simple cases.
> 
> Cc: netdev at vger.kernel.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Acked-by: David S. Miller <davem@davemloft.net>
