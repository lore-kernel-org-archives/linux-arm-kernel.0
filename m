From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 4 Mar 2014 22:40:39 +0100
Subject: [BUG] atmel: spi: scheduling while atomic
In-Reply-To: <5315E33C.5000205@aksignal.cz>
References: <5315E33C.5000205@aksignal.cz>
Message-ID: <20140304214039.GA4441@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ji??,

Thank you for that report.

On 04/03/2014 at 15:29:16 +0100, Ji?? Prchal wrote :
> Hi,
> I discovered some problem when I access anything on SPI. But it
> seems to work correctly, only log is full of this messages. I've
> tried kernels 3.13.0 and 3.14.0, both are the same.
> 
> [    0.875000] atmel_spi f0000000.spi: version: 0x212
> [    0.878906] atmel_spi f0000000.spi: Using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
> [    0.882812] atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 28)
> ...

For now, as a work around, I would suggest disabling dma. I believe it
will solve that particular issue but I didn't try. I would be grateful
if you could post the result.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
