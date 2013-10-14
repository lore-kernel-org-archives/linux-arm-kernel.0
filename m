From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 14 Oct 2013 09:51:48 +0100
Subject: [PATCH V3] ARM: mm: make UACCESS_WITH_MEMCPY huge page aware
In-Reply-To: <alpine.LFD.2.03.1310111615570.3023@syhkavp.arg>
References: <1381489919-2508-1-git-send-email-steve.capper@linaro.org>
 <alpine.LFD.2.03.1310111615570.3023@syhkavp.arg>
Message-ID: <20131014085147.GA8228@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 04:16:15PM -0400, Nicolas Pitre wrote:
> On Fri, 11 Oct 2013, Steve Capper wrote:
> 

[ ... ]

> > Changes in V3:
> > pmd_hugewillfault and pmd_thp_or_huge were erroneously ommitted from
> > pgtable-2level.h causing build problems. Empty stubs are added for now
> > as we don't have huge page support for short descriptors.
> > 
> > Nicolas, can I please re-add your Reviewed-by to this?
> 
> Yes.
> 
> 

Thanks, this is now in the system as: 7858/1.

Cheers,
-- 
Steve
