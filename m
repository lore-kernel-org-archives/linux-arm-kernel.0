From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2011 20:48:26 +0200
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <201109081819.30035.arnd@arndb.de>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<201109081652.20552.arnd@arndb.de>
	<CAGsJ_4wOQddus_Vz5zUjy-4ETOeaiZ+STRD22SwRy+yr4YLaRA@mail.gmail.com>
	<201109081819.30035.arnd@arndb.de>
Message-ID: <CAKnu2Mpnjec-hvfbT0zH1P2mGZKNwTQYgDLGHWUXLmGGQB0_ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/8 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 08 September 2011, Barry Song wrote:
>>
>> this filter is used by all drivers with DMA since every dma channel is
>> fixed to be assigned to one device.
>
> Ok, I see now. I think it would be best to introduce a generic
> 'filter by device tree property' function or alternatively an
> dma_of_request_channel function like this:

You'd have to discuss that with Vinod, the thing is that x86 Atom
systems are using dmaengine for device slave transfers too, and
IIRC these things don't use devicetrees. I may be wrong...

Yours,
Linus Walleij
