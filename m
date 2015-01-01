From: davem@davemloft.net (David Miller)
Date: Wed, 31 Dec 2014 19:20:00 -0500 (EST)
Subject: [PATCH 5/8] net: sun4i-emac: fix error return code
In-Reply-To: <1419872683-32709-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1419872683-32709-1-git-send-email-Julia.Lawall@lip6.fr>
 <1419872683-32709-6-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20141231.192000.244752729516752388.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 29 Dec 2014 18:04:40 +0100

> Return a negative error code on failure.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
 ...
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.
