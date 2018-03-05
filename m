From: kramasub@codeaurora.org (Karthik Ramasubramanian)
Date: Mon, 5 Mar 2018 10:50:35 -0700
Subject: [PATCH v5 4/4] arm64: dts: sdm845: Add serial console support
In-Reply-To: <9d24e89f-38be-59e4-6f76-c273dd4d4e79@codeaurora.org>
References: <20180222061208.2031-1-rnayak@codeaurora.org>
 <20180222061208.2031-5-rnayak@codeaurora.org>
 <20180304195930.GQ93895@bjorns-mbp-2.lan>
 <9d24e89f-38be-59e4-6f76-c273dd4d4e79@codeaurora.org>
Message-ID: <b6421601-a20b-cd98-4dfd-aad7141fecb5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/5/2018 3:43 AM, Rajendra Nayak wrote:
> 
> 
> On 03/05/2018 01:29 AM, Bjorn Andersson wrote:
>> On Wed 21 Feb 22:12 PST 2018, Rajendra Nayak wrote:
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> [..]
>>> +			qup_uart2: serial at a84000 {
>>> +				compatible = "qcom,geni-debug-uart";
>>> +				reg = <0xa84000 0x4000>;
>>> +				reg-names = "se-phys";
>>> +				clock-names = "se-clk";
>>
>> This was changed to "se" in v3 of the GENI patchset, with that this
>> boots nicely again.
> 
> Thanks Bjorn for testing.
> 
> Karthik, it would be good if you could include just this patch from this series as part
> of your GENI series for the next (and subsequent) repost, with updates as needed based on
> binding changes?
> 
I will include this patch in my next submission.

Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
