From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 07:27:30 +0200
Subject: [PATCH v2 07/12] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <CAAQ0ZWSS3ONsF=MLQOJ2u1h3mGErfZ4W2QoSNk4+MQHTC830MQ@mail.gmail.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205220722.00653.marex@denx.de>
 <CAAQ0ZWSS3ONsF=MLQOJ2u1h3mGErfZ4W2QoSNk4+MQHTC830MQ@mail.gmail.com>
Message-ID: <201205220727.30910.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On 22 May 2012 13:22, Marek Vasut <marex@denx.de> wrote:
> > Something like that ... but didn't Linus complain that we have too many
> > files in arch/arm/ ?
> 
> So what do you exactly mean by per-board driver?

Exactly such fixup as there's for mx6q-sabrelite. But then, if you have too 
broken bootloader, you'll need such a fixup for every such board. Or do you want 
to let mach-imx6q.c grow in size with each broken board?

> Regards,
> Shawn

Best regards,
Marek Vasut
