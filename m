From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 10 Dec 2014 09:56:13 -0800
Subject: [PATCH 0/2] arm64: mm: dump: a couple of fixes
In-Reply-To: <1417782895-13657-1-git-send-email-mark.rutland@arm.com>
References: <1417782895-13657-1-git-send-email-mark.rutland@arm.com>
Message-ID: <5488893D.9080307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/5/2014 4:34 AM, Mark Rutland wrote:
> While using the mm dump code, I spotted a couple of issues; one build warning
> and one theoretical failure on systems endowed with plenty of RAM (as with ARM
> [1], though arm64 requires a slightly different resolution). These patches
> (based on next-20141205), fix those issues.
>
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308952.html
>
> Mark Rutland (2):
>    arm64: mm: dump: fix shift warning
>    arm64: mm: dump: don't skip final region
>
>   arch/arm64/mm/dump.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>

If they haven't been picked up yet:

Acked-by: Laura Abbott <lauraa@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
