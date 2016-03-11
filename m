From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Mar 2016 11:09:20 -0500
Subject: [PATCH 1/2] vfio, platform: add support for ACPI while detecting
 the reset driver
In-Reply-To: <56E24012.90002@linaro.org>
References: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
 <56E14858.9050401@linaro.org> <56E1AB38.8020702@codeaurora.org>
 <56E24012.90002@linaro.org>
Message-ID: <56E2EDB0.6030706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/10/2016 10:48 PM, Eric Auger wrote:
>> Well, I haven't seen that warning during testing. I was trying to be more 
>> > proactive.
> Thank you for that. Personally I agree to proceed with the proposed
> change, ie. forbid vfio platform driver to be used if there is no reset
> function found but this should be in a separate patch with explicit
> commit mesg and you should remove dev_warn & related dead code.

OK. I'm getting read to post another series and this will be an independent
change.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
