From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Oct 2014 12:11:28 +0100
Subject: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
In-Reply-To: <alpine.LSU.2.11.1409291443210.2800@eggly.anvils>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
 <alpine.LSU.2.11.1409291443210.2800@eggly.anvils>
Message-ID: <20141001111127.GG12702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 10:51:25PM +0100, Hugh Dickins wrote:
> On Fri, 26 Sep 2014, Steve Capper wrote:
> > This patch provides a general RCU implementation of get_user_pages_fast
> > that can be used by architectures that perform hardware broadcast of
> > TLB invalidations.
> >
> > It is based heavily on the PowerPC implementation by Nick Piggin.
> >
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > Tested-by: Dann Frazier <dann.frazier@canonical.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> Thanks for making all those clarifications, Steve: this looks very
> good to me now.  I'm not sure which tree you're hoping will take this
> and the arm+arm64 patches 2-6: although this one would normally go
> through akpm, I expect it's easier for you to synchronize if it goes
> in along with the arm+arm64 2-6 - would that be okay with you, Andrew?
> I see no clash with what's currently in mmotm.

>From an arm64 perspective, I'm more than happy for Andrew to pick up the
entire series. I already reviewed the patches.

Thanks.

-- 
Catalin
