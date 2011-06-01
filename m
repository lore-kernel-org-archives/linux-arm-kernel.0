From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 1 Jun 2011 13:54:03 +0200
Subject: [PATCH] Fix compile failures by syscore_ops change on s3c2416
In-Reply-To: <4DE4D3F8.1030406@ru.mvista.com>
References: <201105302234.35749.heiko@sntech.de>
	<4DE4D3F8.1030406@ru.mvista.com>
Message-ID: <201106011354.06804.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag 31 Mai 2011 schrieb Sergei Shtylyov:
> On 31-05-2011 0:34, Heiko St?bner wrote:
> > s3c24xx_irq_syscore_ops is only defined in mach-s3c2410/irq.c which is
> > not used by s3c2416.
> > Also s3c2410_dma_chan needs a struct prefix
> 
>     Saying "also" seems a good sign that you should do two patches instead.

you are right of course :-) ... I have redone them now

Heiko
