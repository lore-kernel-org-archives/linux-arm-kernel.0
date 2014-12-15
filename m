From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Mon, 15 Dec 2014 15:44:28 -0800
Subject: [PATCH v9] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <1418686280-12972-1-git-send-email-mitchelh@codeaurora.org>
 (Mitchel Humpherys's message of "Mon, 15 Dec 2014 15:31:20 -0800")
References: <1418686280-12972-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <vnkw1to0h40z.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15 2014 at 03:31:20 PM, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
> From: Matt Wagantall <mattw@codeaurora.org>
>
> It is sometimes necessary to poll a memory-mapped register until its value
> satisfies some condition. Introduce a family of convenience macros that do
> this. Tight-looping, sleeping, and timing out can all be accomplished using
> these macros.
>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Robert Elliott <elliott@hp.com>
> Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
> v8..v9:
>   - Added note in comments about max sleep time (Rob Elliott)

Sorry, just noticed that I somehow dropped these additional comments
that Rob requested...  Let me send a v10 that actually includes them.
Please ignore this version.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
