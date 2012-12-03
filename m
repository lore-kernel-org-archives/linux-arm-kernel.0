From: greg@kroah.com (Greg KH)
Date: Mon, 3 Dec 2012 10:25:45 -0800
Subject: linux-next: manual merge of the arm-soc tree with the slave_dma
 and tree
In-Reply-To: <20121203171232.04772e84d18948bbbcafdeef@canb.auug.org.au>
References: <20121203171232.04772e84d18948bbbcafdeef@canb.auug.org.au>
Message-ID: <20121203182545.GA32702@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 05:12:32PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/dma/mv_xor.c between commit d51e88b99533 ("dma: Convert dev_printk
> (KERN_<LEVEL> to dev_<level>(") from the slave-dma tree, commits
> a7d6e3ec28bb ("dma: remove use of __devexit_p") and 463a1f8b3cee ("dma:
> remove use of __devinit") from the driver-core tree and various commits
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks good to me, thanks.

greg k-h
