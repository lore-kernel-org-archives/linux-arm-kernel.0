From: panchaxari.prasannamurthy@linaro.org (Panchaxari Prasannamurthy Tumkur)
Date: Thu, 12 Dec 2013 16:33:46 +0530
Subject: [PATCH CFT] ARM:S5P64X0: Enable ARM_PATCH_PHYS_VIRT and
 AUTO_ZRELADDR by default
In-Reply-To: <26167386.hX5eWUjT6T@flatron>
References: <1386825152-398-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
 <26167386.hX5eWUjT6T@flatron>
Message-ID: <CAAunhULO5n3rf5_Q+HwExd=kadsPC_rTz9oP8kXKM7krBetbdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz

> Could you explain the purpose of this change on S5P64x0?
>
> This is actually quite a poor platform choice. As of today, the kernel
> is stuck with supporting just SMDK6440/6450 boards, which are proprietary
> development boards and it doesn't look like any further boards will show
> up in future. Kukjin has actually proposed removing support for this
> platform at all and I consider this reasonable.
>
> Kukjin, should we proceed with removal?

The purpose of this patch is with the greater intent of consolidating
ARM-32 kernel. Which means a generic kernel for ARM-32 processors.

Hence these platform supported configs are introduced as default for
that particular platform.

I hope i answered your question. Else please mail me with further queries.

thanks
Panchaxari
