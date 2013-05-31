From: john.stultz@linaro.org (John Stultz)
Date: Fri, 31 May 2013 13:40:46 -0700
Subject: [PATCH 5/4] sched: Make ARM's sched_clock generic for all
 architectures
In-Reply-To: <1367369675-13535-1-git-send-email-sboyd@codeaurora.org>
References: <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
 <1367369675-13535-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <51A90ACE.7070906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2013 05:54 PM, Stephen Boyd wrote:
> Here's the patch to make sched_clock generic. I didn't know
> where to put it so I just made a new file in kernel/sched
> for now.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Hey Stephen,
     Baruch just asked a question about moving arm's sched_clock.c to be 
generic, and it sounded familiar, so I dug around and found this mail 
from a few months ago.

Just wanted to follow up and see what the status is with this? Is this 
queued somewhere already?

thanks
-john
