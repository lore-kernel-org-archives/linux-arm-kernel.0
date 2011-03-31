From: gdavis@mvista.com (George G. Davis)
Date: Wed, 30 Mar 2011 21:05:45 -0400
Subject: SMP soft lockup on smp_call_function_many when doing
	flush_tlb_page
In-Reply-To: <AANLkTikwmSw0h-CKwF+MkkTymbURVWuoS3L7YTnL_EZB@mail.gmail.com>
References: <AANLkTimk6zmQNdZaVaxDbd5Ff+75RERhrxgmsbM55vs1@mail.gmail.com>
	<1299591229.19820.91.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinX+1wwxcSPf0HfyE1pG1TJv7zf0cQ9aP+DWCCD@mail.gmail.com>
	<AANLkTi=HzSUP0aXSBSg=5zKLngJz+8Jwqr+oLrW+tEyL@mail.gmail.com>
	<1299603582.19820.125.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimzAdhfp-ARyFU4kcGytf9PL4Ypziu1c1PtH=tC@mail.gmail.com>
	<1299685848.19820.353.camel@e102109-lin.cambridge.arm.com>
	<20110330051849.GB13080@mvista.com>
	<AANLkTikwmSw0h-CKwF+MkkTymbURVWuoS3L7YTnL_EZB@mail.gmail.com>
Message-ID: <20110331010545.GM13080@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 09:37:51AM +0100, Catalin Marinas wrote:
> On 30 March 2011 06:18, George G. Davis <gdavis@mvista.com> wrote:
> > On Wed, Mar 09, 2011 at 03:50:48PM +0000, Catalin Marinas wrote:
> >> On Wed, 2011-03-09 at 15:22 +0000, saeed bishara wrote:
> >> > > Did you get a chance to try this patch?
> >> > yes, it works fine
> >>
> >> Thanks for trying. I'll add a commit log and post.
> >
> > Based on your comments here [1], it looks like your fix for this [2] is
> > superseeded by [3] which is already applied [4]. ?Can you confirm?
> 
> Yes, it's been fixed by the commit you mentioned.

Thanks!

--
Regards,
George

> 
> -- 
> Catalin
