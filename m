From: dannenberg@ti.com (Andreas Dannenberg)
Date: Wed, 11 May 2016 08:07:41 -0500
Subject: [PATCH 1/2] ARM: dts: dra7: Add ocmcram nodes
In-Reply-To: <1462909782-14639-2-git-send-email-d-gerlach@ti.com>
References: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
 <1462909782-14639-2-git-send-email-d-gerlach@ti.com>
Message-ID: <20160511130741.GR20461@borg.dal.design.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 02:49:41PM -0500, Dave Gerlach wrote:
> Add all ocmcram nodes to dra7.dtsi using the generic mmio-sram driver.
> DRA7xx and AM57xx families of SoCs can contain three ocmcram regions of
> SRAM, one of 512kb and also an optional two additional of 1Mb each. Mark
> the two additional 1MB regions of SRAM as disabled as only ocmcmram1 is
> on all variants of the SoCs, then depending on which specific variant
> is in use the ocmcram2 and ocmcram3 nodes can be enabled in the board
> dts file if the data manual for that part number indicates the ocmcram
> region is available.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Andreas Dannenberg <dannenberg@ti.com>


Regards,

--
Andreas Dannenberg
Texas Instruments Inc
