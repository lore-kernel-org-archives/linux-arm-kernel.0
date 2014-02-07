From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Feb 2014 00:59:46 +0100
Subject: [PATCH v2 00/12] Samsung PM consolidation part 2 (multiplatform)
In-Reply-To: <20140207221537.GA12714@quad.lixom.net>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
 <20140207221537.GA12714@quad.lixom.net>
Message-ID: <52F57372.7010507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07.02.2014 23:15, Olof Johansson wrote:
> On Thu, Feb 06, 2014 at 08:12:45PM +0100, Tomasz Figa wrote:
>
>> On Exynos4210-based Trats, Exynos4412-based Trats2 and Exynos5250-based
>> Arndale boards (except suspend/resume, which is broken because of
>> unrelated reasons):
>
> Has this been reported, and is it being worked on by anyone?

Yes, reported quite a long time ago by Vikas Sajjan of Samsung/Linaro, 
but I'm not sure if anybody is working to fix it.

I've been looking into this for a while, but couldn't really find 
anything except that it hangs when PMU starts power state transtion 
after CPU executing WFI instruction.

Best regards,
Tomasz
