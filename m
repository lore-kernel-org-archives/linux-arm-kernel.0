From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 20 May 2015 15:38:08 -0700
Subject: [PATCH v3 0/4] mtd: mxc_nand: fix 8 bit ECC and large oob
In-Reply-To: <cover.1431504091.git.baruch@tkos.co.il>
References: <cover.1431504091.git.baruch@tkos.co.il>
Message-ID: <20150520223808.GR11598@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 11:17:35AM +0300, Baruch Siach wrote:
> This patch series fixes mxc_nand bugs that I encountered while trying to use 8
> bit ECC mode on i.MX25 with the Micron MT29F8G08ABABA flash chip.
> 
> Many thanks to Uwe Kleine-K?nig for guiding me through the process of
> debugging and fixing, for contributing a clean-up patch to this series, and
> for reviewing the rest.
> 
> This series applies on v4.1-rc1.
> 
> This is version 3 of the patch series, adding Reviewed-by and Acked-by tags
> from Sascha Hauer and Uwe Kleine-K?nig. Patch 4/4 renamed a function as
> suggested by Uwe Kleine-K?nig.
> 
> Version 2 of the patch series
> (http://thread.gmane.org/gmane.linux.drivers.mtd/58687), addressed the
> comments and suggestion of Uwe Kleine-K?nig on the first series
> (http://thread.gmane.org/gmane.linux.ports.arm.kernel/408635). See each patch
> for detailed per-patch changelog.

Pushed the first 3 to l2-mtd.git. Thanks all!

I have one comment on the 4th.

Brian
