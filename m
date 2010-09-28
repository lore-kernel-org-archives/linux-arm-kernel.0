From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 28 Sep 2010 14:13:19 +0400
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <AANLkTinuQsSP1EHWn5DS_9PMrsgj+fpjLOOkpnnBaf8Q@mail.gmail.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	<AANLkTinuQsSP1EHWn5DS_9PMrsgj+fpjLOOkpnnBaf8Q@mail.gmail.com>
Message-ID: <4CA1BFBF.2090102@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-09-2010 13:13, Linus Walleij wrote:

>> Add support for Texas Instuments Communication Port Programming Interface 4.1
>> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.

> Sorry for late feedback ...

>> +++ linux-davinci/arch/arm/common/cppi41.c

> Can you migrate this driver to drivers/dma/cppi41.c and use the
> DMAengine interface like so many DMA drivers we have created
> recently, or is there some very special characteristics about this
> DMA controller meriting it to be placed in arch/arm/*?

    I have once studied the possibility of doing this driver under 
drivers/dma/, and found that hardly achievable. Maybe I should try again though...

> Yours,
> Linus Walleij

WBR, Sergei
