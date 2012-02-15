From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 15 Feb 2012 13:03:58 -0700
Subject: [PATCH 0/4] spi/omap: Adaptation to Device Tree
In-Reply-To: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
References: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
Message-ID: <20120215200358.GB25779@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 06:37:33PM +0100, Benoit Cousson wrote:
> Hi Grant,
> 
> You might think I'm harassing you with all these series, but it looks like
> you are the maintainer of all the stuff I care about for the moment :-)
> 
> Here are a couple of SPI patches + the addition of a SPI ethernet device
> needed for sdp4430 board.
> 
> This driver is still relying on a valid bus_number which is clearly bad.
> A cleanup is definitively needed, and will be done later.
> 
> This series is based on lo/master (a37cdd9) + for_3.4/dt_base branch to get
> the needed cleanup and fixes for OMAP.
> 
> Please note that due to the changes in the various OMAP DTS files, I have
> to base this series on top of my other DT series (gpio for example), otherwise
> the merge of the two series will generate some merge conflict in the DTS since
> they are both adding some new nodes at the exact same location.

Merge conflicts of this type are just fine when they are both adding new stuff.
The resolution of such conflicts are easy.

g.
