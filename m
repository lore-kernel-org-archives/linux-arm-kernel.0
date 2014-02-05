From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 5 Feb 2014 09:27:57 -0600
Subject: [PATCH v2 0/5] Split mach-msm into legacy and mach-qcom
 (multiplatform)
In-Reply-To: <20140205004732.GB12815@codeaurora.org>
References: <1391553532-27001-1-git-send-email-galak@codeaurora.org>
 <20140205004732.GB12815@codeaurora.org>
Message-ID: <86DB2204-BB01-4B64-AF0C-5A0045DA8ABD@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 4, 2014, at 6:47 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 02/04, Kumar Gala wrote:
>> This is the splits the Qualcomm MSM platform into legacy support that we will
>> not try and convert to multiplatform and multiplatform support.
>> 
>> - k
>> 
>> Changes from v1:
>> * Added patch to remove hotplug.c
>> * Added patch to rename msm_ to qcom_
>> * Changes the Kconfig to drop CPU_V7
>> * used wfi() in cpu_die function
>> * Added git tree to MAINTAINERS file
> 
> What's the plan for this series combined with my SMP series? It
> looks like this isn't based on those patches, so we'll have some
> conflicts with the msm to qcom rename but it should be fairly
> minor.

I?ve rebased the smp patch series on top of this set, so will post the new version short (hopefully once we close on these).

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
