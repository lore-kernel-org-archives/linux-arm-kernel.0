From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 20 Aug 2018 18:15:12 +0530
Subject: [PATCH v12 13/14] cpufreq: qcom: Re-organise kryo cpufreq to use
 it for other nvmem based qcom socs
In-Reply-To: <20180817150902.GA19164@rob-hp-laptop>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <1534248753-2440-14-git-send-email-sricharan@codeaurora.org>
 <20180817150902.GA19164@rob-hp-laptop>
Message-ID: <a89bd80c-bdfc-77ed-1de9-9cad38da7cf5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 8/17/2018 8:39 PM, Rob Herring wrote:
> Hi, this email is from Rob's (experimental) review bot. I found a couple
> of common problems with your patch. Please see below.
> 
> On Tue, 14 Aug 2018 17:42:32 +0530, Sricharan R wrote:
>> The kryo cpufreq driver reads the nvmem cell and uses that data to
>> populate the opps. There are other qcom cpufreq socs like krait which
>> does similar thing. Except for the interpretation of the read data,
>> rest of the driver is same for both the cases. So pull the common things
>> out for reuse.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> 
> The preferred subject prefix is "dt-bindings: <binding dir>: ...".
> 

 ok, will change and keep the bindings update part out for this and the next
 patch.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
