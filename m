From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 6 Feb 2018 10:16:44 +0530
Subject: [PATCH 01/15] firmware: qcom: scm: Add ipq4019 soc compatible
In-Reply-To: <20180205022530.xf64gqeijicewdla@rob-hp-laptop>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-2-git-send-email-sricharan@codeaurora.org>
 <20180205022530.xf64gqeijicewdla@rob-hp-laptop>
Message-ID: <23641ff4-59c9-cf14-8fef-12614e265512@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 2/5/2018 11:37 AM, Rob Herring wrote:
> On Mon, Jan 29, 2018 at 10:41:15AM +0530, Sricharan R wrote:
>> Add the compatible for ipq4019.
>> This does not need clocks to do scm calls.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
>>  drivers/firmware/qcom_scm.c                             | 3 +++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

 Thanks !!

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
