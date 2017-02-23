From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 23 Feb 2017 14:46:49 -0600
Subject: [PATCH v2] arm64: Fix the kernel panic() on QDF2400 platform
In-Reply-To: <1487880125-1371-1-git-send-email-shankerd@codeaurora.org>
References: <1487880125-1371-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <4d97310a-4b91-07ac-1ce0-faacb8da03b0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2017 02:02 PM, Shanker Donthineni wrote:
> The commit 38fd94b0275c 'arm64: Work around Falkor erratum 1003' has
> been added to fix the hardware bug but causing a system crash. The

"causes"

> value of the register x1 which contains 'struct mm_struct *' should
> be preserved inside macro pre_ttbr0_update_workaround.

The subject line seems a bit vague and alarmist to me.  In my opinion, this 
is more descriptive:

arm64: qcom: pre_ttbr0_update_workaround should not clobber register x1



-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
