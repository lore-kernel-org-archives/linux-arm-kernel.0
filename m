From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 3 Feb 2016 13:32:47 -0500
Subject: [PATCH V13 08/10] dma: qcom_hidma: read the channel id from HW
In-Reply-To: <20160201151455.GA10961@rob-hp-laptop>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-9-git-send-email-okaya@codeaurora.org>
 <20160201151455.GA10961@rob-hp-laptop>
Message-ID: <56B247CF.5060408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2016 10:14 AM, Rob Herring wrote:
> On Fri, Jan 29, 2016 at 05:35:11PM -0500, Sinan Kaya wrote:
>> Removing the flexibility to choose the event channel as there is no real
>> use case right now. We have been using the values in ACPI that match the HW
>> defaults. OS is reading the event-channel from the HW register now.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  3 --
>>  drivers/dma/qcom/hidma.c                           | 39 +---------------------
>>  2 files changed, 1 insertion(+), 41 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 


Thanks Rob,
I'll merge this patch to the existing documentation and code on the next rev.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
