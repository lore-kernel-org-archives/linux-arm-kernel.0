From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Aug 2016 12:10:26 -0700
Subject: [PATCH v1 03/14] clk: twl6040: Rename the driver and use
 consistent names in the code
In-Reply-To: <20160530085522.30398-4-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
 <20160530085522.30398-4-peter.ujfalusi@ti.com>
Message-ID: <20160815191026.GY361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30, Peter Ujfalusi wrote:
> The driver is to provide the functional clock to OMAP4/5 McPDM. The clock
> is named as pdmclk in the documentations so change the function names,
> structure names and variables to align with this.
> At the same time rename the driver from "twl6040-clk" to "twl6040-pdmclk".
> This can be done w/o regression since the clock driver is not in use at
> the moment, the MFD core driver is not even registering the device for it.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
