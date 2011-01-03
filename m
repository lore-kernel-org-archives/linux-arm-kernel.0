From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 16:34:47 +0000
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <4D21F3F2.6090302@mvista.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	<4D21F3F2.6090302@mvista.com>
Message-ID: <20110103163447.GB2911@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 07:06:10PM +0300, Sergei Shtylyov wrote:
> Hello.
>
> On 15-05-2010 22:14, Sergei Shtylyov wrote:
>
>> Add support for Texas Instuments Communication Port Programming Interface 4.1
>> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.
>
>> At this moment, only the DMA controller and queue manager are supported.
>> Support for the buffer manager is lacking but these chips don't have it anyway.
>
>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
>
>    Russell, you have recently discarded this patch from your patch 
> system. Can we know the reason?

It was recently discussed with TI, and various people raised concerns
about it.  I don't remember the exact details, and I wish they'd raise
them with the patch author directly.  It may have been that it's
inventing its own API rather than using something like the DMA engine
API.

Adding linux-omap to try to get a response there.
