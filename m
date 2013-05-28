From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 28 May 2013 09:59:35 +0100
Subject: [PATCH v2 3/4] ARM: mm: HugeTLB support for LPAE systems.
In-Reply-To: <20130524110306.GC18272@arm.com>
References: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
 <1369323080-9673-4-git-send-email-steve.capper@linaro.org>
 <20130524110306.GC18272@arm.com>
Message-ID: <20130528085934.GA15590@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2013 at 12:03:06PM +0100, Catalin Marinas wrote:
> On Thu, May 23, 2013 at 04:31:19PM +0100, Steve Capper wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > This patch adds support for hugetlbfs based on the x86 implementation.
> 
> Can we not share the x86 code as you are proposing for arm64 already?
>

Yes, we can. I didn't want one patch set dependent on another so opted to
make the ARMv7 one self-contained for now. I was planning on changing this
with a future patch.

Cheers,
-- 
Steve
 
> -- 
> Catalin
