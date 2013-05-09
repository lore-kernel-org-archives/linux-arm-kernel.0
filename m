From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 9 May 2013 09:27:13 +0100
Subject: [RFC PATCH v2 07/11] ARM64: mm: Make PAGE_NONE pages read only
 and no-execute.
In-Reply-To: <20130508164341.GG20820@mudshark.cambridge.arm.com>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-8-git-send-email-steve.capper@linaro.org>
 <20130508164341.GG20820@mudshark.cambridge.arm.com>
Message-ID: <20130509082712.GA28801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 05:43:41PM +0100, Will Deacon wrote:
> On Wed, May 08, 2013 at 10:52:39AM +0100, Steve Capper wrote:
 
> Whilst it's not strictly needed for pte_exec to work, I think you should
> include PTE_PXN in the PAGE_NONE definitions as well.

Agreed, it does look a little weird without it.

Cheers,
-- 
Steve
