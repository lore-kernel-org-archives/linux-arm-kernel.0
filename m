From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 Apr 2014 10:10:04 +0200
Subject: dma_alloc_coherent and cache?
In-Reply-To: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
References: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
Message-ID: <20140415081004.GJ22546@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 09:43:38AM +0400, Lee Essen wrote:
> Hi,
> 
> I'm working on a driver for a Marvell switch device (98dx4122) where the basic interface closely resembles the mv643xx_eth device.

Hi Lee

There is basic support for this SoC in the kernel. See
arch/arm/boot/dts/kirkwood-98dx4122.dtsi and
arch/arm/boot/dts/kirkwood-km_kirkwood.dts which is keymile's
reference design.

Keymile are the experts for this device within the kernel community,
so maybe they can comment?

   Andrew
