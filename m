From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 14 Mar 2016 08:49:50 +0100 (CET)
Subject: [PATCH v2 1/2] Irq/mbigen:Change the mbigen node definition in
 dt binding file
In-Reply-To: <1457937907-14008-2-git-send-email-majun258@huawei.com>
References: <1457937907-14008-1-git-send-email-majun258@huawei.com>
 <1457937907-14008-2-git-send-email-majun258@huawei.com>
Message-ID: <alpine.DEB.2.11.1603140844490.3657@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Majun,

On Mon, 14 Mar 2016, MaJun wrote:

First of all the prefix for irq chip drivers is not "Irq/".

Hint: git log drivers/irqchip 

> From: Ma Jun <majun258@huawei.com>
> 
> For mbigen module, there is a special case that more than one mbigen
> device nodes use the same reg definition in DTS when these devices
> exist in the same mbigen hardware module.

There is a special case, so what?
 
> To fix the mbigen IO remap problem, the mbigen node definition and

Which problem?

> structure are changed based on Mark Rutland's suggestion.

That's really uselss. Nobody has any idea what Mark suggested and in which way
it fixes that unspecified problem you are talking about.

Thanks,

	tglx
