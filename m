From: ckadabi@codeaurora.org (ckadabi at codeaurora.org)
Date: Tue, 28 Nov 2017 16:42:47 -0800
Subject: gicv3: 1 of N model implementation related
Message-ID: <e83aac509dcef816bbf279c4ba2bed1a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark:

I have some question related to gicv3 driver on 1 of N distribution 
model.
Looking at the linux kernel implementation the interrupt is always 
affined to the first online cpu and does not use the 1 of N distribution 
model.
As per the Gic spec 1 of N model could help to achieve low latency as 
handling the interrupts as there are more PE's participating in handling 
the interrupt.

Is there a reason the Linux kernel driver does not implement the 1 of N 
model?

Thanks,
Channa

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
