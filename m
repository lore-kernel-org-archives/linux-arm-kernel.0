From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 6 Oct 2012 16:50:44 +0100
Subject: [RFC 00/24] OMAP serial driver flow control fixes, and
 preparation for DMA engine conversion
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <20121006165044.30528336@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 6 Oct 2012 13:38:03 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Hi,
> 
> This series of patches fixes multiple flow control issues with the OMAP
> serial driver, and prepares the driver for DMA engine conversion.  We
> require hardware assisted flow control to work properly for DMA support
> otherwise we have no way to properly pause the transmitter.

All the generic parts

Acked-by: Alan Cox <alan@linux.intel.com>
