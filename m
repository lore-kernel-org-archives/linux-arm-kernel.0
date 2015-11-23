From: davem@davemloft.net (David Miller)
Date: Mon, 23 Nov 2015 15:49:46 -0500 (EST)
Subject: [PATCH] VSOCK: constify vmci_transport_notify_ops structures
In-Reply-To: <1448127557-22280-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1448127557-22280-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20151123.154946.1373634995645161672.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 21 Nov 2015 18:39:17 +0100

> The vmci_transport_notify_ops structures are never modified, so declare
> them as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.
