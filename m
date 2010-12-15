From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 18:17:32 -0700 (MST)
Subject: [PATCH 05/12] OMAP4: PRCM: Add SCRM header file
In-Reply-To: <20101214063447.21555.64470.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
	<20101214063447.21555.64470.stgit@twilight.localdomain>
Message-ID: <alpine.DEB.2.00.1012141816380.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Dec 2010, Paul Walmsley wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> 
> Add the header file with scrm registers absolute address, offset
> and bitfields.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

This patch has been moved to the earlier 'pwrdm_prcm_a_2.6.38' series.  
Also the base address macro name has been changed from OMAP4_SCRM to 
OMAP4_SCRM_BASE.


- Paul
