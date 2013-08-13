From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 13 Aug 2013 16:08:57 -0700
Subject: [ARM ATTEND] Specification of ARM memory features and related
 discussion of said features
Message-ID: <520ABC89.1040806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to attend the ARM summit to discuss the specification of 
various memory features. Most devices right now have relatively simple 
memory layouts but as ARM catches up with x86 or other arches in terms 
of memory features, we're going to need a good way to specify all the 
necessary details. Possible topics:

- Tradeoffs of complete removal of regions of memory via memblock_remove 
vs. passing in regions of memory
- Defining memory of different interleaving/speeds
- Defining hotpluggable/power-offable memory
- NUMA or NUMA like behavior
- bootloader specification of memory features vs. devicetree 
specification of memory features
- Specification of 'software' memory maps with features such as CMA[1]

I'm mostly interested in devicetree specification but I'm also 
interested in discussion of any of the features themselves and what ARM 
would need to match other arches.

Thanks,
Laura

[1] http://lists.linaro.org/pipermail/linaro-mm-sig/2013-August/003359.html
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
