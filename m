From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Sep 2016 20:58:30 +0100
Subject: next-20160914 build: 2 failures 3 warnings (next-20160914)
In-Reply-To: <20160914171137.GF27974@sirena.org.uk>
References: <E1bk5OS-0000Vu-1C@optimist> <20160914171137.GF27974@sirena.org.uk>
Message-ID: <20160914195830.GF638@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Sep 2016, Mark Brown wrote:

> On Wed, Sep 14, 2016 at 09:18:08AM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build both arm and arm64 allmodconfig due to:
> 
> > 	arm64-allmodconfig
> > ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> > 
> > 	arm-allmodconfig
> > ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> 
> due to 262d5cc6ceb293 (mfd: tps65217: Add support for IRQs) since
> irq_set_parent() isn't exported.

Arnd is talking to Thomas about a possible solution.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
