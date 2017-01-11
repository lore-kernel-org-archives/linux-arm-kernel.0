From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 11 Jan 2017 12:40:42 -0600
Subject: [PATCH v3 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170111183738.GD29247@leverpostej>
References: <20170111144118.17062-1-cov@codeaurora.org>
 <20170111144118.17062-2-cov@codeaurora.org>
 <20170111180627.GG20288@e104818-lin.cambridge.arm.com>
 <20170111183339.GC29247@leverpostej>
 <5da456f8-fcc5-b6e2-d58b-01a671da595b@codeaurora.org>
 <20170111183738.GD29247@leverpostej>
Message-ID: <2069d58c-0b81-dad4-511f-05e7d002eb34@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 12:37 PM, Mark Rutland wrote:
> The name, as it is, is perfectly descriptive.
>
> Let's not sacrifice legibility over a non-issue.

I don't want to kick a dead horse or anything, but changing it to 
QCOM_FLKR_ERRATUM_1003 would eliminate all the spacing problems without 
sacrificing anything.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
