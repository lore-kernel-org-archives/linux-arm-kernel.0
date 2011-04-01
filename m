From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 1 Apr 2011 16:55:02 -0600
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
Message-ID: <BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 4:26 PM, John Linn <John.Linn@xilinx.com> wrote:
> I?m getting ready to submit a patch to add SMP to Xilinx code. I notice that
> smp_cross_call for all GIC based platforms is duplicated across each
> platform in smp.h.
>
>
>
> I thought I?d try to jump in to help with some cleanup, although I realize
> it?s minimal, I have to start somewhere.
>
>
>
> What about moving the smp_cross_call for GIC based designs into gic.h?

Go for it.  It's an obvious cleanup.

g.
