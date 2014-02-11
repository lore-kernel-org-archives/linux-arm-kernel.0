From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 11 Feb 2014 09:00:44 -0600
Subject: [PATCH 2/5] clocksource: qcom: Move clocksource code out of
 mach-msm
In-Reply-To: <52F9ECC7.8010702@linaro.org>
References: <1391553421-26914-1-git-send-email-galak@codeaurora.org>
 <1391553421-26914-3-git-send-email-galak@codeaurora.org>
 <52F9ECC7.8010702@linaro.org>
Message-ID: <0038EEDD-6836-4171-9EB9-C1A70029AE8D@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 11, 2014, at 3:26 AM, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 02/04/2014 11:36 PM, Kumar Gala wrote:
>> We intent to share the clocksource code for MSM platforms between legacy
>> and multiplatform supported qcom SoCs.
>> 
>> Acked-by: Olof Johansson <olof@lixom.net>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> 
> Hi Kumar,
> 
> through which tree do you expect this patch to be upstream ?

The linux-qcom to keep things sane there.  So an ack would be great.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
