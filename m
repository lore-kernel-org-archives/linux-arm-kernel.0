From: davem@davemloft.net (David Miller)
Date: Fri, 08 Aug 2014 10:28:58 -0700 (PDT)
Subject: [PATCH 12/14] ll_temac: delete unneeded test before of_node_put
In-Reply-To: <1407492475-26283-12-git-send-email-Julia.Lawall@lip6.fr>
References: <1407492475-26283-12-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20140808.102858.2296909606267579093.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri,  8 Aug 2014 12:07:53 +0200

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Of_node_put supports NULL as its argument, so the initial test is not
> necessary.
> 
> Suggested by Uwe Kleine-K?nig.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
 ...
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.
