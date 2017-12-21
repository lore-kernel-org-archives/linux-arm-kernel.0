From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 21 Dec 2017 14:56:49 +0530
Subject: [PATCH v5 05/15] devicetree: bindings: Document qcom,hfpll
In-Reply-To: <20171220211147.p555i5eest3ycsbc@rob-hp-laptop>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-6-git-send-email-sricharan@codeaurora.org>
 <20171220211147.p555i5eest3ycsbc@rob-hp-laptop>
Message-ID: <dbd699f1-2798-594e-b34f-39510d4e4e60@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 12/21/2017 2:41 AM, Rob Herring wrote:
> On Tue, Dec 19, 2017 at 09:24:50PM +0530, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> Adds bindings document for qcom,hfpll instantiated within
>> the Krait processor subsystem as separate register region.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  .../devicetree/bindings/clock/qcom,hfpll.txt       | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
> 
> "dt-bindings: " is the preferred subject prefix. Otherwise,
> 

 ok, will update for the next version.

> Reviewed-by: Rob Herring <robh@kernel.org>

 Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
