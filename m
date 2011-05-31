From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 31 May 2011 15:41:44 +0400
Subject: [PATCH] Fix compile failures by syscore_ops change on s3c2416
In-Reply-To: <201105302234.35749.heiko@sntech.de>
References: <201105302234.35749.heiko@sntech.de>
Message-ID: <4DE4D3F8.1030406@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 31-05-2011 0:34, Heiko St?bner wrote:

> s3c24xx_irq_syscore_ops is only defined in mach-s3c2410/irq.c which is
> not used by s3c2416.
> Also s3c2410_dma_chan needs a struct prefix

    Saying "also" seems a good sign that you should do two patches instead.

WBR, Sergei
