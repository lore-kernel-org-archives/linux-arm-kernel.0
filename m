From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 2 Apr 2018 11:37:23 +0530
Subject: [PATCH v5 07/13] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c3
 board file
In-Reply-To: <20180327171414.GJ1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-8-git-send-email-sricharan@codeaurora.org>
 <20180327171414.GJ1403@tuxbook-pro>
Message-ID: <4af1f110-ccbf-872f-21fd-d0557b6e6b1b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/27/2018 10:44 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
>> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C3";
> 
> Add a compatible to the board file.
> 

 ok.

> Also, things like alias would make sense to put in the board unless
> there's some restriction making every board having the same layout.
> 
>> +};

 hmm. i also thought of having them in board specific files initially.
 In this case, at-least the aliases for serial nodes seems to match across
 dk-01/04/07 base variants. But might be if we add something else in future
 it might not be common. Yeah, would move it to board specific files.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
