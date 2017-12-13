From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 13 Dec 2017 16:40:48 +0530
Subject: [PATCH v4 05/12] clk: qcom: Add MSM8960/APQ8064's HFPLLs
In-Reply-To: <20171212203631.kyruwhtpmigkwfat@rob-hp-laptop>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-6-git-send-email-sricharan@codeaurora.org>
 <20171212203631.kyruwhtpmigkwfat@rob-hp-laptop>
Message-ID: <807f2d6d-123e-331d-e630-45cb5d42b751@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 12/13/2017 2:06 AM, Rob Herring wrote:
> On Fri, Dec 08, 2017 at 03:12:23PM +0530, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> Describe the HFPLLs present on MSM8960 and APQ8064 devices.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  drivers/clk/qcom/gcc-msm8960.c               | 172 +++++++++++++++++++++++++++
>>  include/dt-bindings/clock/qcom,gcc-msm8960.h |   2 +
> 
> For the binding,
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

 Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
