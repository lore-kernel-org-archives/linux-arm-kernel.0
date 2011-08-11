From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Aug 2011 09:30:33 +0100
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH
	2/2] GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO
	controller)
In-Reply-To: <CAGsJ_4ysq4RruD5oP=B6ZvNCa0baFPxtLdbgpsC8wZQsT1r1yQ@mail.gmail.com>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<CAKnu2MpjOT8y5DfeAtrgBAKh0asqNouyhuin=z+ScAwx0Fa5rA@mail.gmail.com>
	<CAGsJ_4yb9vvKYzyXwQSwaBw1VnZWbv4jGBC4qe7uD032DL0y9A@mail.gmail.com>
	<201108091515.47961.arnd@arndb.de>
	<CAGsJ_4ysq4RruD5oP=B6ZvNCa0baFPxtLdbgpsC8wZQsT1r1yQ@mail.gmail.com>
Message-ID: <20110811083033.GC4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 10:25:58AM +0800, Barry Song wrote:
> now every SoCs have different DMA APIs due to different DMA controller:

We already have a solution to this.  It's called dmaengine.  See
drivers/dma, include/linux/dmaengine.h and Documentation/dmaengine.txt
There is work going on at present to convert the OMAP and Samsung SoC
specific DMA support to dmaengine.
