From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 01 Oct 2012 17:34:28 -0700
Subject: [PATCH] ARM: hw_breakpoint: Clear breakpoints before enabling
 monitor mode
In-Reply-To: <20120924171934.GE5522@mudshark.cambridge.arm.com>
References: <1348160260-19486-1-git-send-email-sboyd@codeaurora.org>
 <20120920173556.GQ4654@mudshark.cambridge.arm.com>
 <20120924171934.GE5522@mudshark.cambridge.arm.com>
Message-ID: <506A3694.4070004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/12 10:19, Will Deacon wrote:
> Ok, I've pushed a bunch of patches to my hw-breakpoint branch (head commit
> 55cb726797c7). I'll post them to the list after the merge window, but please
> do take them for a spin if you get a chance.
>

Forgot to reply here. Took them for a spin last week with that commit.
No more boot hangs but I can't say much else beyond that. When you post
to the list I'll add my tested-by.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
