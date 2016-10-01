From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 1 Oct 2016 23:08:27 +0530
Subject: [PATCH 0/4] ARM: davinci: Remove DMA resources for MMC/SPI
In-Reply-To: <20160928103530.15291-1-peter.ujfalusi@ti.com>
References: <20160928103530.15291-1-peter.ujfalusi@ti.com>
Message-ID: <95c32453-ca2a-7754-ffa5-97aff1618d32@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 September 2016 04:05 PM, Peter Ujfalusi wrote:
> Hi,
> 
> The drivers for davinci MMC and SPI have been converted to the new DMAengine API
> and no longer rely on the IORESOURCE_DMA.
> This is the case for at least one release cycle so now we can remove the
> IORESOURCE_DMA for these devices.

Hi Peter, applied to v4.10/cleanup branch of my tree. Thanks!

~Sekhar
