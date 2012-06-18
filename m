From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 18 Jun 2012 12:11:50 +0530
Subject: [CFT 07/11] spi: omap2-mcspi: add DMA engine support
In-Reply-To: <20120614125012.GG31187@n2100.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaZv-0003tz-6F@rmk-PC.arm.linux.org.uk>
 <20120614115335.GE31187@n2100.arm.linux.org.uk>
 <20120614120842.GF31187@n2100.arm.linux.org.uk>
 <20120614125012.GG31187@n2100.arm.linux.org.uk>
Message-ID: <4FDECDAE.8070700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 June 2012 06:20 PM, Russell King - ARM Linux wrote:
> because, at the time when omap2_mcspi_setup() is called, spi->dev is
> not bound, and so is outside of the devres valid lifetime of that
> struct device.
Agree,
Apologies for breaking in the initial commit.
