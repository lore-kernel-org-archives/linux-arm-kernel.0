From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 2 May 2012 01:33:57 -0600 (MDT)
Subject: [PATCH] ARM: OMAP3: Fix CM register bit masks
In-Reply-To: <1335529405-14230-1-git-send-email-rnayak@ti.com>
References: <1335529405-14230-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1205020133470.19695@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Apr 2012, Rajendra Nayak wrote:

> The register bits for MPU_CLK_SRC and IVA2_CLK_SRC
> in CM_CLKSEL1_PLL register are 3 bits wide.
> Fix the MASK definition accordingly.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 3.5.

- Paul
