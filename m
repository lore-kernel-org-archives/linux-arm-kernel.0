From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 4 Aug 2016 09:59:43 -0400
Subject: [PATCH 10/10] dmaengine: qcom_hidma: add MSI support for
 interrupts
In-Reply-To: <20160804124641.GE9681@localhost>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-11-git-send-email-okaya@codeaurora.org>
 <20160724064256.GA9681@localhost>
 <e6560c8b-e18e-9e32-5b51-c1c12d8551ce@codeaurora.org>
 <20160804124641.GE9681@localhost>
Message-ID: <497ddb6c-0233-657f-72c6-b844b798ff11@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/4/2016 8:46 AM, Vinod Koul wrote:
>> > Yes, I do have a new device ID for platforms with MSI capability. 
>> > 
>> > Which new binding are you referring to?
> If you have "QCOM8062" why do you need DT to tell hidma-1.1 ?

Unfortunately, DT cannot do a binding with the ACPI names. Similarly, ACPI
cannot do a binding with the DT name. 

The structure of binding name is also subject to different kind of rules
for DT and ACPI.

This driver supports both device tree and ACPI. That's why, two different
names are required.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
