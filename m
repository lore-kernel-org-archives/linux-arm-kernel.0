From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Feb 2016 16:46:46 +0000
Subject: [PATCH v5sub2 0/8] arm64: implement virtual KASLR
In-Reply-To: <CAKv+Gu9RmhaYBHOKwsPNynJ4Zia2kSJ6Yr3U4c6F13UHdbzFtw@mail.gmail.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu-AhLcatkDsQVeoFGJ+pTEwaW1Hy9M-fY1-VWvRc_E47w@mail.gmail.com>
 <20160205173248.GJ6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_v1sXM7sivz+Uu86ZG3=Th7wqqh7M1N8wF7Ess4NdTZQ@mail.gmail.com>
 <CAGXu5j+JpwRrVy1b_h+LJ4sCzsT7BV9RdcD0CvR-4aVJQhCpvg@mail.gmail.com>
 <20160208121430.GL6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-=RLS8Zgn_evmoUUSHqSVfaw9_hjVMgfg1FZGRDGFVag@mail.gmail.com>
 <20160208161918.GT6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9RmhaYBHOKwsPNynJ4Zia2kSJ6Yr3U4c6F13UHdbzFtw@mail.gmail.com>
Message-ID: <20160208164646.GU6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 05:20:41PM +0100, Ard Biesheuvel wrote:
> On 8 February 2016 at 17:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Feb 08, 2016 at 03:30:47PM +0100, Ard Biesheuvel wrote:
> >> However, the arm64 patch (#6) now conflicts with futex.h in -rc3 after
> >> the PAN fix, not sure how to best address that ...
> >
> > I'll have a look.
> 
> Note that the fix is trivial, but I don't know who should be carrying
> the fix is all

I'll push the arm64 for-next/core branch (including your series) out
against 4.5-rc3, so there won't be any conflict.

-- 
Catalin
