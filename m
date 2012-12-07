From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 6 Dec 2012 17:14:33 -0700
Subject: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
 spi-orion
In-Reply-To: <20121206235311.GB21694@titan.lakedaemon.net>
References: <20121121192335.GA14868@obsidianresearch.com>
 <20121206142521.4185A3E0948@localhost>
 <20121206172504.GB9676@obsidianresearch.com>
 <20121206232305.719E23E0B24@localhost>
 <20121206234917.GF25069@obsidianresearch.com>
 <20121206235311.GB21694@titan.lakedaemon.net>
Message-ID: <20121207001433.GG25069@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 06, 2012 at 06:53:11PM -0500, Jason Cooper wrote:
> On Thu, Dec 06, 2012 at 04:49:17PM -0700, Jason Gunthorpe wrote:
> > Jason: Do you have any of these possibly affected boards with a SPI
> > flash to test linux-next? dove, dreamplug, ts219 and lsxl
> 
> Yep, dreamplug ought to do.

Hmm, I just reviewed all the FLASH P/Ns datasheets in the affected DT
files, and they are all mode 0/mode 3 compatible - that is the linux
default mode so I expect everything to work OK.

If your dreamplug is fine lets just leave it?

Jason
