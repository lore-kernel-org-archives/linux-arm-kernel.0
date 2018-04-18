From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 18 Apr 2018 12:45:20 +0530
Subject: [v5,05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
In-Reply-To: <2284833.pBtR1QS54F@bentobox>
References: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
 <2641190.FRMBLJWkCS@bentobox> <2284833.pBtR1QS54F@bentobox>
Message-ID: <734eb6eb-9af9-d599-81f1-ec66d9cd839c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sven,

On 4/18/2018 12:37 PM, Sven Eckelmann wrote:
> On Mittwoch, 18. April 2018 08:59:46 CEST Sven Eckelmann wrote:
> [...]
>> I would not know how to disable QSEE on these boards and thus would assume 
>> that it should be part of this dtsi.
> 
> 
> Just did some reviews of the reserved-memory regions in other QCA devices and 
> it looks like this tz and smem are often directly added to the SoC dtsi. So I 
> will prepare a similar change for qcom-ipq4019.dtsi and this would then solve 
> it for AP-DK01/04/07 and no changes in the board-family specific dtsi would be 
> necessary.
> 
> But maybe someone has an objection because tz and smem can actually be 
> disabled in a sane way on these SoCs and thus it would be better to have these 
> regions in the board specific dts(i) files. We will see...

 Right, will add the above change to soc.dtsi in V6. Does that sound ok for you ?

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
