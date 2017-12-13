From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 13 Dec 2017 16:41:26 +0530
Subject: [PATCH v4 09/12] clk: qcom: Add Krait clock controller driver
In-Reply-To: <20171212205104.vnnjr3w56w4mrfh6@rob-hp-laptop>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-10-git-send-email-sricharan@codeaurora.org>
 <20171212205104.vnnjr3w56w4mrfh6@rob-hp-laptop>
Message-ID: <55bd6d93-9d0a-7fcb-0fb9-0e8fd9c21974@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 12/13/2017 2:21 AM, Rob Herring wrote:
> On Fri, Dec 08, 2017 at 03:12:27PM +0530, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> The Krait CPU clocks are made up of a primary mux and secondary
>> mux for each CPU and the L2, controlled via cp15 accessors. For
>> Kraits within KPSSv1 each secondary mux accepts a different aux
>> source, but on KPSSv2 each secondary mux accepts the same aux
>> source.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  .../devicetree/bindings/clock/qcom,krait-cc.txt    |  22 ++
> 
> Please make bindings a separate patch.
> 

 ok.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
