From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 2 Apr 2015 10:13:18 +0200
Subject: [PATCH] ASoC: atmel-pcm-dma: increase buffer_bytes_max
In-Reply-To: <20150401203342.GH6023@sirena.org.uk>
References: <1427744437-14610-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150401203342.GH6023@sirena.org.uk>
Message-ID: <20150402081318.GF20669@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2015 at 21:33:42 +0100, Mark Brown wrote :
> On Mon, Mar 30, 2015 at 09:40:37PM +0200, Alexandre Belloni wrote:
> > atmel-pcm-dma is not limited to a buffer size of 64kB like atmel-pcm-pdc.
> > Increase buffer_bytes_max to 512kB to allow for higher bit rates (i.e. 32bps at
> > 192kHz) to work correctly. By default, keep the prealloc at 64kB.
> 
> Applied, but please look into Lars' suggestion - we should be able to
> just figure everything out from the DMA controller.

This is definitively on the TODO list.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
