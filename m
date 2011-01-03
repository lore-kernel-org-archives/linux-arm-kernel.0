From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 03 Jan 2011 19:06:10 +0300
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <201005152214.53993.sshtylyov@ru.mvista.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
Message-ID: <4D21F3F2.6090302@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-05-2010 22:14, Sergei Shtylyov wrote:

> Add support for Texas Instuments Communication Port Programming Interface 4.1
> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.

> At this moment, only the DMA controller and queue manager are supported.
> Support for the buffer manager is lacking but these chips don't have it anyway.

> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> Signed-off-by: Sekhar Nori<nsekhar@ti.com>

    Russell, you have recently discarded this patch from your patch system. 
Can we know the reason?

WBR, Sergei
