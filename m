From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Sep 2016 11:21:50 +0100
Subject: next-20160914 build: 2 failures 3 warnings (next-20160914)
In-Reply-To: <20160914171137.GF27974@sirena.org.uk>
References: <E1bk5OS-0000Vu-1C@optimist> <20160914171137.GF27974@sirena.org.uk>
Message-ID: <20160919102150.GI10189@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 06:11:37PM +0100, Mark Brown wrote:
> On Wed, Sep 14, 2016 at 09:18:08AM +0100, Build bot for Mark Brown wrote:

> Today's -next fails to build both arm and arm64 allmodconfig due to:

> > 	arm64-allmodconfig
> > ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

> > 	arm-allmodconfig
> > ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

> due to 262d5cc6ceb293 (mfd: tps65217: Add support for IRQs) since
> irq_set_parent() isn't exported.

This is still breaking the build, do we have any ETA on getting the
export added?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/1958a83c/attachment.sig>
