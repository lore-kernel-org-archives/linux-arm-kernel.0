From: mporter@ti.com (Matt Porter)
Date: Mon, 17 Sep 2012 13:27:54 -0400
Subject: [PATCH v2 0/2] Add pinctrl support to omap2-mcspi
In-Reply-To: <1347902538-21208-1-git-send-email-mporter@ti.com>
References: <1347902538-21208-1-git-send-email-mporter@ti.com>
Message-ID: <20120917172754.GR27758@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:22:16PM -0400, Matt Porter wrote:
> Changes since v1:
> 	- warns that pins are not configured by the driver rather than
> 	  exiting 
> 	- dummy states are only enabled for OMAP platforms where DT is
> 	  not populated
> 
> This series enables pinctrl support for McSPI. Platforms that boot only
> from DT and rely on pinctrl to set pinmuxes appropriately require this
> for omap2-mcspi operation.
> 
> It has been tested on AM335x BeagleBone with an Adafruit SPI LCD attached
> and regression tested on Beagleboard xM booting in the !DT case, using
> board-omap3evm.c. 
> 
> The series applies on top of Tony's dt-devel branch.

*sigh*, that's devel-dt of course.
