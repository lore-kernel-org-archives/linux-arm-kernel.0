From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 21 May 2013 11:05:31 +0100
Subject: hugetlbfs support plan for ARM
In-Reply-To: <519ACF4B.9070502@gmail.com>
References: <3E54258959B69E4282D79E01AB1F32B7044F299D@DFLE11.ent.ti.com>
 <519ACF4B.9070502@gmail.com>
Message-ID: <20130521100507.GA14248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 09:35:07AM +0800, bill4carson wrote:
> Hi, Karichri
> 
> On 2013?05?21? 02:26, Karicheri, Muralidharan wrote:
> >Hi Bill,
> >
> >I see the patch at http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/084360.html
> >
> >Is there a plan to merge this to upstream Linux kernel? I would appreciate your response on this.
> 
> I tried to post several round of this patch set, but haven't got more time to merge it.
> Steve Capper from ARM proposed both HUGEPAGE and THP in below link,
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/148451.html
> 
> Look https://wiki.linaro.org/LEG/Engineering/Kernel/HugePages here to find what you needs.
> 

Hi,
Apologies for the delay, I am working on rebasing HugeTLB+THP for 3.10-rc1. An
issue with PROT_NONE has arisen, and I'm currently fixing this.

Cheers,
-- 
Steve

> >Thanks.
> >
> >Murali Karicheri
> >
> >/Software Design Engineer/
> >
> 
> -- 
> ?????????,??????????
> 
> --bill
