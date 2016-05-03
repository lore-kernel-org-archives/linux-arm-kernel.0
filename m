From: davem@davemloft.net (David Miller)
Date: Tue, 03 May 2016 13:03:23 -0400 (EDT)
Subject: [PATCH] VSOCK: constify vsock_transport structure
In-Reply-To: <1462106955-22131-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1462106955-22131-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160503.130323.1929865256655720740.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun,  1 May 2016 14:49:15 +0200

> The vsock_transport structure is never modified, so declare it as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.
