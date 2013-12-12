From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 12 Dec 2013 12:40:59 +0100
Subject: [PATCH CFT] ARM:S5P64X0: Enable ARM_PATCH_PHYS_VIRT and
 AUTO_ZRELADDR by default
In-Reply-To: <CAAunhULO5n3rf5_Q+HwExd=kadsPC_rTz9oP8kXKM7krBetbdQ@mail.gmail.com>
References: <1386825152-398-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
 <26167386.hX5eWUjT6T@flatron>
 <CAAunhULO5n3rf5_Q+HwExd=kadsPC_rTz9oP8kXKM7krBetbdQ@mail.gmail.com>
Message-ID: <3126277.U19MiHChc4@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 of December 2013 16:33:46 Panchaxari Prasannamurthy Tumkur wrote:
> Hi Tomasz
> 
> > Could you explain the purpose of this change on S5P64x0?
> >
> > This is actually quite a poor platform choice. As of today, the kernel
> > is stuck with supporting just SMDK6440/6450 boards, which are proprietary
> > development boards and it doesn't look like any further boards will show
> > up in future. Kukjin has actually proposed removing support for this
> > platform at all and I consider this reasonable.
> >
> > Kukjin, should we proceed with removal?
> 
> The purpose of this patch is with the greater intent of consolidating
> ARM-32 kernel. Which means a generic kernel for ARM-32 processors.

OK. So do you have plans to send similar patches for other, more active
(and closer to having multiplatform support) platforms, such as s3c64xx,
s5pv210 and exynos?

In case of s5p64x0 probably the only person capable of testing it is
Kukjin, as we don't have any other active people with boards based on
these SoCs.

Best regards,
Tomasz
