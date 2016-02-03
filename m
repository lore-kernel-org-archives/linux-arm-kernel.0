From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 3 Feb 2016 13:32:01 -0500
Subject: [PATCH V13 08/10] dma: qcom_hidma: read the channel id from HW
In-Reply-To: <20160201153542.GA20396@leverpostej>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-9-git-send-email-okaya@codeaurora.org>
 <20160201153542.GA20396@leverpostej>
Message-ID: <56B247A1.20503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2/1/2016 10:35 AM, Mark Rutland wrote:
>> Removing the flexibility to choose the event channel as there is no real
>> > use case right now. We have been using the values in ACPI that match the HW
>> > defaults. OS is reading the event-channel from the HW register now.
> Fold this in to the patches adding the binding and the driver.
> 
> There is no reason to add this then remove it within the same series.
> 
> Mark.
> 

Before I post the next rev, I'd like to see if I missed something in the series when 
it comes to your comments. 

Can you please take a look and let me know?

Sinan

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
