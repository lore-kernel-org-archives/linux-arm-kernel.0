From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 23 Feb 2017 15:11:52 -0600
Subject: [PATCH v2] arm64: Fix the kernel panic() on QDF2400 platform
In-Reply-To: <3fb32277-9d9e-c84d-4e98-c19ace690433@codeaurora.org>
References: <1487880125-1371-1-git-send-email-shankerd@codeaurora.org>
 <4d97310a-4b91-07ac-1ce0-faacb8da03b0@codeaurora.org>
 <3fb32277-9d9e-c84d-4e98-c19ace690433@codeaurora.org>
Message-ID: <a6fa565f-28ce-f488-dd1e-b5d010c6409a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2017 03:05 PM, Shanker Donthineni wrote:
> Why do you want keep 'pre_ttbr0_update_workaround' in subject, nothing
> wrong with macro definition itself. Problem with the caller, not passing
> the right arguments.

Ok, how about this:

arm64: qcom: do not use x1 when calling pre_ttbr0_update_workaround

"Fix the kernel panic() on QDF2400 platform" could mean almost anything. 
There could plenty of future kernel panics on the QDF2400.

Also, I think our legal review would insist on saying "Qualcomm Technologies 
QDF2400", which would make the line too long.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
