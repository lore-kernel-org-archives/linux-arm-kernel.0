From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 31 Oct 2017 07:36:14 -0500
Subject: [PATCH 1/4] Revert "gpio: set up initial state from
 .get_direction()"
In-Reply-To: <CAOMZO5CbPCJe76AMeRHNBUwfEu5jdWUEAqkZuxLBbgOHoLx_MQ@mail.gmail.com>
References: <1509396602-1936-1-git-send-email-timur@codeaurora.org>
 <1509396602-1936-2-git-send-email-timur@codeaurora.org>
 <1509440926.10233.77.camel@linux.intel.com>
 <a6c8b2ac-29de-4ec7-7b3f-fac1b5b16942@codeaurora.org>
 <CAOMZO5CbPCJe76AMeRHNBUwfEu5jdWUEAqkZuxLBbgOHoLx_MQ@mail.gmail.com>
Message-ID: <d424fea5-6b28-5cb0-5fda-e71a64bf8528@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/17 7:33 AM, Fabio Estevam wrote:
> In this case checkpatch should have given you an error due to the
> missing Signed-off-by tag:-)

Indeed!  Something must be broken in my checkpatch invocation.  I did 
think that it was odd that I didn't get any complaints.  Thanks.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
