From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 12 Sep 2013 13:22:25 -0500
Subject: [PATCH v7 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <20130909160154.8D7183E0F23@localhost>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
 <20130829224637.D09183E1222@localhost> <52209278.8040106@samsung.com>
 <DAF223EB-C84C-4E82-A24A-ACD0A3A0559F@codeaurora.org>
 <20130909160154.8D7183E0F23@localhost>
Message-ID: <13185491-534E-4547-8412-5704346EA2DC@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 9, 2013, at 11:01 AM, Grant Likely wrote:

> 
> The generic form for do-not-touch memory:
> 	compatible = "reserved-memory";
> - I've dropped '-region' because I think it is redundant
> - The kernel will not make use of this memory except for when a driver picks it up
> 
> For contiguous memory:
> 	compatible = "contiguous-memory", "reserved-memory"

Should the phandle references still be 'memory-region' ?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
