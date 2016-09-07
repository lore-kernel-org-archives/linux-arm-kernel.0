From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 Sep 2016 17:33:55 -0700
Subject: [PATCH 1/7] clk: gxbb: expose USB clocks
In-Reply-To: <20160904213152.25837-2-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-2-martin.blumenstingl@googlemail.com>
Message-ID: <20160907003355.GQ12510@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04, Martin Blumenstingl wrote:
> USB0_DDR_BRIDGE and USB1_DDR_BRIDGE1 are needed for the related
> dwc2 usb controller. USB, USB0 and USB1 are needed for the PHYs.
> Expose these clocks to DT and comment out in clk driver.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Is authorship correct on this patch? Did Jerome author it
instead?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
