From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 23 Feb 2017 13:29:15 -0600
Subject: [PATCH] arm64: Fix the kernel panic() on QDF2400 platform
In-Reply-To: <20170223144550.GE27512@arm.com>
References: <1487819448-8715-1-git-send-email-shankerd@codeaurora.org>
 <20170223144550.GE27512@arm.com>
Message-ID: <CAOZdJXUA0jAS-u_w5G0Nugm-6MiFkN49_nOvEuWQ7PpyAbeo2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 8:45 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> Whilst I'm pleased that you've sent a fix (and I'll pick it up), I have
> to ask... did anybody actually test the original patch? If so, why wasn't
> this found earlier?

First, Shanker's going to post a V2 with an improved patch description.

As for testing it, well, I can't explain how that bug was missed.
Looking at it, it's obvious now.  Unfortunately, the developer who
wrote the code no longer works for Qualcomm.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
