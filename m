From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Sep 2016 13:22:39 -0400
Subject: [PATCH V3 01/10] Documentation: DT: qcom_hidma: update binding
 for MSI
In-Reply-To: <20160923153910.GA23150@rob-hp-laptop>
References: <1473960166-30155-1-git-send-email-okaya@codeaurora.org>
 <1473960166-30155-2-git-send-email-okaya@codeaurora.org>
 <20160923153910.GA23150@rob-hp-laptop>
Message-ID: <92feb6b5-b9b9-394d-3cb6-d095df339ebc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/23/2016 11:39 AM, Rob Herring wrote:
>> Required properties:
>> > -- compatible: must contain "qcom,hidma-1.0"
>> > +- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
>> > +for MSI capable HW.
> Do you have an SoC part number yet? If so, please use that instead.
> 

Unfortunately, I have the same problem like "qcom, hidma-1.0". The SoC name is not settled
yet and same IP gets used in multiple SoCs. Each IP reports its own version number. This is
one of the reasons why I sticked to versioning instead of SoC name.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
