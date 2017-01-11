From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 11 Jan 2017 12:35:55 -0600
Subject: [PATCH v3 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170111183339.GC29247@leverpostej>
References: <20170111144118.17062-1-cov@codeaurora.org>
 <20170111144118.17062-2-cov@codeaurora.org>
 <20170111180627.GG20288@e104818-lin.cambridge.arm.com>
 <20170111183339.GC29247@leverpostej>
Message-ID: <5da456f8-fcc5-b6e2-d58b-01a671da595b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 12:33 PM, Mark Rutland wrote:
> It'll need to affect all lines since the kconfig column needs to expand
> by at least one character to fit QCOM_FALKOR_ERRATUM_1003.

Or we can make the macro shorter.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
