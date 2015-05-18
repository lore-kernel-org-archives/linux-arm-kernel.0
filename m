From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 18 May 2015 17:57:45 +0300
Subject: [RESEND][PATCH 1/5] ARM: sa1100: add platform functions to handle
 PWER settings
In-Reply-To: <20150518145245.GZ2067@n2100.arm.linux.org.uk>
References: <1431960247-32646-1-git-send-email-dbaryshkov@gmail.com>
 <20150518145245.GZ2067@n2100.arm.linux.org.uk>
Message-ID: <CALT56yMTYn4ApnrdBo-mxfv2h-eG=iXBmwxh3fXdYwwgSF8k0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-18 17:52 GMT+03:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> No cover letter, so I'll top-reply to the first patch, since my comments
> aren't specific to this patch.
>
> Patches 1-3 look fine, no problem there.
>
> Patches 4 and 5 I think should be in the reverse order - update the IRQ
> code first, and make it independent of things in arch/arm/mach-sa1100,
> and once that's done, move it out of there.

Thank you for the review. I'll push 1-3 to patch tracker now and
will resubmit 4,5 in the evening.

-- 
With best wishes
Dmitry
