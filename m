From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Nov 2017 10:34:22 +0000
Subject: gicv3: 1 of N model implementation related
In-Reply-To: <e83aac509dcef816bbf279c4ba2bed1a@codeaurora.org>
References: <e83aac509dcef816bbf279c4ba2bed1a@codeaurora.org>
Message-ID: <20171129103421.niju3tkdah3tzajw@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 04:42:47PM -0800, ckadabi at codeaurora.org wrote:
> Hi Mark:

Hi,

I'm afraid I don't know much about GICv3 or the irq infrastrcuture in
the kernel . Did you mean to ask Marc Zyngier (Cc'd)?

Thanks,
Mark.

> I have some question related to gicv3 driver on 1 of N distribution model.
> Looking at the linux kernel implementation the interrupt is always affined
> to the first online cpu and does not use the 1 of N distribution model.
> As per the Gic spec 1 of N model could help to achieve low latency as
> handling the interrupts as there are more PE's participating in handling the
> interrupt.
> 
> Is there a reason the Linux kernel driver does not implement the 1 of N
> model?
> 
> Thanks,
> Channa
> 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
