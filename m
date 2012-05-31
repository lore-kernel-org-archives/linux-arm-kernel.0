From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:29:39 +0800
Subject: [RFC 03/34] dmaengine: virt-dma: add support for cyclic DMA
 periodic callbacks
In-Reply-To: <20120530080216.GH12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIqg-0006yu-5Z@rmk-PC.arm.linux.org.uk>
 <CACRpkdba_aFbyBt9hkYqBR=oY6fq0KHchjGcuS_NhbOMbE0Owg@mail.gmail.com>
 <20120530080216.GH12217@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYM1DX7BGd3EQLiqaZmRUk=NRAFsN0E_4ActW4tx5WgOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 4:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, May 30, 2012 at 03:52:53PM +0800, Linus Walleij wrote:
>>
>> This last thing was something we have to fix right?
>> Like for each driver to keep a counter of completed periods
>> and call the handler repeatedly if N > 1.
>
> No, I don't think we should do that - ALSA doesn't require it, and ALSA
> is about the only user of this.

OK then there won't be any problems, let's go ahead with this.

Yours,
Linus Walleij
