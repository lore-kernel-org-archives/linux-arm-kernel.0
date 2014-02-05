From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 4 Feb 2014 16:47:33 -0800
Subject: [PATCH v2 0/5] Split mach-msm into legacy and mach-qcom
 (multiplatform)
In-Reply-To: <1391553532-27001-1-git-send-email-galak@codeaurora.org>
References: <1391553532-27001-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140205004732.GB12815@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04, Kumar Gala wrote:
> This is the splits the Qualcomm MSM platform into legacy support that we will
> not try and convert to multiplatform and multiplatform support.
> 
> - k
> 
> Changes from v1:
> * Added patch to remove hotplug.c
> * Added patch to rename msm_ to qcom_
> * Changes the Kconfig to drop CPU_V7
> * used wfi() in cpu_die function
> * Added git tree to MAINTAINERS file

What's the plan for this series combined with my SMP series? It
looks like this isn't based on those patches, so we'll have some
conflicts with the msm to qcom rename but it should be fairly
minor.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
