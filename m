From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 31 Oct 2017 07:28:12 -0500
Subject: [PATCH 1/4] Revert "gpio: set up initial state from
 .get_direction()"
In-Reply-To: <1509440926.10233.77.camel@linux.intel.com>
References: <1509396602-1936-1-git-send-email-timur@codeaurora.org>
 <1509396602-1936-2-git-send-email-timur@codeaurora.org>
 <1509440926.10233.77.camel@linux.intel.com>
Message-ID: <a6c8b2ac-29de-4ec7-7b3f-fac1b5b16942@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/17 4:08 AM, Andy Shevchenko wrote:
> Can you preserve the style and indentation of the commit?
> Does checkpatch warn you about style? (It's apparently not a net
> subsystem)

I ran checkpatch on it and it didn't complain.

Also, I don't think that when reverting a patch, I am also supposed to 
to fix cosmetic changes of the code that existed before the original patch.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
