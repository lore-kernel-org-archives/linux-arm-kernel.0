From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 09 Oct 2015 08:44:42 +0530
Subject: [PATCH v3 4/9] clk: qcom: create virtual child device for TSENS
In-Reply-To: <20151008232110.GK26883@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org>
 <1444280468-17159-5-git-send-email-rnayak@codeaurora.org>
 <20151008232110.GK26883@codeaurora.org>
Message-ID: <56173122.2030203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/09/2015 04:51 AM, Stephen Boyd wrote:
> On 10/08, Rajendra Nayak wrote:
>> 8960 family of devices have TSENS as part of GCC in hardware.
>> Hence DT would represent a GCC node with GCC properties as well
>> as TSENS. Create a virtual platform child device here for TSENS
>> so the driver can probe it and use the parent (GCC) to extract DT
>> properties.
>>
>> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
> 
> Applied to clk-next with some massaging. Is there going to be an
> update to the gcc binding too?

Thanks, I will update the gcc bindings as part of the patch which
adds support for 8960 tsens.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
