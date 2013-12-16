From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Dec 2013 11:00:54 +0100
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
In-Reply-To: <20131216104738.6f845aabd0e3b609ed9ca170@canb.auug.org.au>
References: <20131216104738.6f845aabd0e3b609ed9ca170@canb.auug.org.au>
Message-ID: <52AECF56.8020508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/2013 00:47, Stephen Rothwell :
> Hi Simon,
> 
> Today's linux-next merge of the renesas tree got a conflict in
> drivers/clk/Makefile between commit 0ad6125b1579 ("clk: at91: add PMC
> base support") from the arm-soc tree and commit 10cdfe9f327a ("clk:
> shmobile: Add R-Car Gen2 clocks support") from the renesas tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Fine for me.

Thanks. Bye,
-- 
Nicolas Ferre
