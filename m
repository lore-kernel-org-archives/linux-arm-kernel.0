From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 3 Oct 2016 09:39:25 -0400
Subject: [PATCH V4 04/10] dmaengine: qcom_hidma: configure DMA and MSI for
 OF
In-Reply-To: <20161003033851.GP2467@localhost>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
 <1475115167-5898-5-git-send-email-okaya@codeaurora.org>
 <20161001061710.GF2467@localhost>
 <da6536a3-353e-1364-7074-9d3dcbcc4171@codeaurora.org>
 <20161003033851.GP2467@localhost>
Message-ID: <a36242e2-99a4-b519-094e-b6d2bcdd27da@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/2/2016 11:38 PM, Vinod Koul wrote:
>> I followed the pattern in of_platform_device_create_pdata function. of_msi_configure does
>> > nothing if MSI is not enabled as irq_find_matching_host returns NULL. It didn't have any
>> > side effects on my testing either.
> yeah later on I did look up the of_msi_configure() and I suspected this. I
> think it would be worthwhile to document this assumption here.

Sure, let me do that.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
