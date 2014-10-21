From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 21 Oct 2014 10:12:32 -0700
Subject: [PATCH v6 1/2] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <1413323610-27484-2-git-send-email-mitchelh@codeaurora.org>
 (Mitchel Humpherys's message of "Tue, 14 Oct 2014 14:53:29 -0700")
References: <1413323610-27484-1-git-send-email-mitchelh@codeaurora.org>
 <1413323610-27484-2-git-send-email-mitchelh@codeaurora.org>
Message-ID: <vnkw1tq1z6rj.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14 2014 at 02:53:29 PM, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
> From: Matt Wagantall <mattw@codeaurora.org>
>
> It is sometimes necessary to poll a memory-mapped register until its value
> satisfies some condition. Introduce a family of convenience macros that do
> this. Tight-looping, sleeping, and timing out can all be accomplished using
> these macros.
>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
> Changes since v5:
>   - Use a shift instead of a divide in the poll loop.
> ---
>  include/linux/iopoll.h | 213 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 213 insertions(+)
>  create mode 100644 include/linux/iopoll.h

I realize I sent this at a bad time (ELCE) but were there any more
comments on this patch?


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
