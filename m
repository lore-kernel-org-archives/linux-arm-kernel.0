From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 15 Aug 2013 20:07:52 -0700
Subject: [ARM ATTEND] Clock DT bindings
Message-ID: <520D9788.5080805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You asked for specific topics. So, here's one:

Clock DT bindings discussion on:
* Allowing producers to export clocks by names.
* Allowing consumers to list clocks by "producer phandle, clock name".
* Should we allow for -clock magic similar to regulators?
* Should the entire clock tree be represented in DT.

I would like to attend the ARM summit to represent the needs of SoCs 
with complicated clocking HW. I have worked on clocks for about 5 years 
(since MSM started running Linux) and would like to throw in my opinion 
on what clock DT bindings would work well, why and help come up with a 
solution that works well for everyone.

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
