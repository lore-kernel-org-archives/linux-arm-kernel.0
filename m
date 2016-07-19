From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Jul 2016 08:42:20 -0400
Subject: [PATCH 01/10] Documentation: DT: qcom_hidma: update binding for
 MSI
In-Reply-To: <20160719103755.GC27022@leverpostej>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-2-git-send-email-okaya@codeaurora.org>
 <20160719103755.GC27022@leverpostej>
Message-ID: <02522721-6213-82c3-310f-22313f69e7b7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/19/2016 6:37 AM, Mark Rutland wrote:
>>  Required properties:
>> > -- compatible: must contain "qcom,hidma-1.0"
>> > +- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
>> > +for MSI capable HW.
> Don't we need properties to describe the MSI details (e.g. sideband data
> like DeviceID)?
> 
> Thanks,
> Mark.
> 

You are right. I forgot to copy those.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
