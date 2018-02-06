From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 6 Feb 2018 10:14:29 +0530
Subject: [PATCH v6 15/15] dt-bindings: cpufreq: Document
 operating-points-v2-krait-cpu
In-Reply-To: <20180206042729.GH28462@vireshk-i7>
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
 <1517890108-8140-16-git-send-email-sricharan@codeaurora.org>
 <20180206042729.GH28462@vireshk-i7>
Message-ID: <d21cf85e-def9-66d8-aed1-cd1407c36fdb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On 2/6/2018 9:57 AM, Viresh Kumar wrote:
> On 06-02-18, 09:38, Sricharan R wrote:
>> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
>> that has KRAIT processors the voltage/current value of each OPP
>> varies based on the silicon variant in use.
>> operating-points-v2-krait-cpu specifies the phandle to nvmem efuse cells
>> and the operating-points-v2 table for each opp. The qcom-cpufreq driver
>> reads the efuse value from the SoC to provide the required information
>> that is used to determine the voltage and current value for each OPP of
>> operating-points-v2 table when it is parsed by the OPP framework.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  .../devicetree/bindings/cpufreq/krait-cpufreq.txt  | 363 +++++++++++++++++++++
>>  1 file changed, 363 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
> 
> You can add my Ack if Rob also finds everything to be fine here.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

 Thanks !!

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
