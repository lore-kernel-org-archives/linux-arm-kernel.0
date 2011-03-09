From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Mar 2011 15:50:48 +0000
Subject: SMP soft lockup on smp_call_function_many when doing
	flush_tlb_page
In-Reply-To: <AANLkTimzAdhfp-ARyFU4kcGytf9PL4Ypziu1c1PtH=tC@mail.gmail.com>
References: <AANLkTimk6zmQNdZaVaxDbd5Ff+75RERhrxgmsbM55vs1@mail.gmail.com>
	<1299591229.19820.91.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinX+1wwxcSPf0HfyE1pG1TJv7zf0cQ9aP+DWCCD@mail.gmail.com>
	<AANLkTi=HzSUP0aXSBSg=5zKLngJz+8Jwqr+oLrW+tEyL@mail.gmail.com>
	<1299603582.19820.125.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimzAdhfp-ARyFU4kcGytf9PL4Ypziu1c1PtH=tC@mail.gmail.com>
Message-ID: <1299685848.19820.353.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-09 at 15:22 +0000, saeed bishara wrote:
> > Did you get a chance to try this patch?
> yes, it works fine

Thanks for trying. I'll add a commit log and post.

-- 
Catalin
