From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Sep 2016 18:11:37 +0100
Subject: next-20160914 build: 2 failures 3 warnings (next-20160914)
In-Reply-To: <E1bk5OS-0000Vu-1C@optimist>
References: <E1bk5OS-0000Vu-1C@optimist>
Message-ID: <20160914171137.GF27974@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 09:18:08AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build both arm and arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> 
> 	arm-allmodconfig
> ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

due to 262d5cc6ceb293 (mfd: tps65217: Add support for IRQs) since
irq_set_parent() isn't exported.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160914/8b4658ac/attachment.sig>
