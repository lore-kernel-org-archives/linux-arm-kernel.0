From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 24 Sep 2014 14:26:10 -0500
Subject: [PATCH] ARM: qcom: Update SoC compatibles we support
In-Reply-To: <54230E9A.7020109@codeaurora.org>
References: <1411582838-24159-1-git-send-email-galak@codeaurora.org>
 <54230E9A.7020109@codeaurora.org>
Message-ID: <42858D66-62FA-4F89-A1A2-584DD6A7BE34@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 24, 2014, at 1:34 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 09/24/14 11:20, Kumar Gala wrote:
>> Move to just using the SoC name in the compatible list so we don't need
>> to update this for every board going forward.  Also added "qcom,msm8974"
>> to the list as we support "qcom,apq8074" already (the modemless version
>> of "qcom,msm8974").
>> 
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> ---
> 
> Or just remove the file entirely. Things work without having to add
> anything here anyway.

I?d prefer there to be some filter, but maybe you are right.  I doubt we?ll add too many other platforms to this going forward.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
