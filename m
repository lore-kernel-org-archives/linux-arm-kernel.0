From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 14:07:14 +0800
Subject: [PATCH v2 07/12] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <201205220727.30910.marex@denx.de>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205220722.00653.marex@denx.de>
 <CAAQ0ZWSS3ONsF=MLQOJ2u1h3mGErfZ4W2QoSNk4+MQHTC830MQ@mail.gmail.com>
 <201205220727.30910.marex@denx.de>
Message-ID: <20120522060713.GS6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 07:27:30AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On 22 May 2012 13:22, Marek Vasut <marex@denx.de> wrote:
> > > Something like that ... but didn't Linus complain that we have too many
> > > files in arch/arm/ ?
> > 
> > So what do you exactly mean by per-board driver?
> 
> Exactly such fixup as there's for mx6q-sabrelite. But then, if you have too 
> broken bootloader, you'll need such a fixup for every such board. Or do you want 
> to let mach-imx6q.c grow in size with each broken board?
As Shawn said, this patch is trying to abstract common things.
We don't need to repeat the code that interpret output-gpios.

Generally discuss often draw no conclusion. So let's talk about
code.

Thanks
Richard
> 
> > Regards,
> > Shawn
> 
> Best regards,
> Marek Vasut
> 
