From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 23 Feb 2012 16:28:55 +0100
Subject: [SPI/MFD] Fix build/section mismatch warnings in da9052-spi.c
In-Reply-To: <20120213095101.GB15338@n2100.arm.linux.org.uk>
References: <20120213095101.GB15338@n2100.arm.linux.org.uk>
Message-ID: <20120223152855.GC24377@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Feb 13, 2012 at 09:51:01AM +0000, Russell King - ARM Linux wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> drivers/mfd/da9052-spi.c:65: warning: 'da9052_spi_remove' defined but not used
A similar patch has been sent by Axel Lin, and applied to my for-next branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
