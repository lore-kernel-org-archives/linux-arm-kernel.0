From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 3 Oct 2013 09:45:38 -0500
Subject: Use of drivers/platform and matching include?
Message-ID: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we look at upstreaming more support for the Qualcomm MSM SoCs there are a number of drivers or library like routines that are unique to the MSM platform, we are thinking that putting them under:

drivers/platform/qcom/

would make sense.  In addition there are headers that might need to get shared with drivers in other locations so I wanted to see what the take was on introducing:

include/linux/platform/qcom/

An example driver would be the means we utilize to communicate memory regions between various HW blocks on the SoC.  So a video/media core driver might need access to a header/functions from the memory region driver.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
