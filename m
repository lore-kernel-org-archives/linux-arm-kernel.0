From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 12:51:37 +0100
Subject: [PATH V2 4/6] arm: mm: Enable RCU fast_gup
In-Reply-To: <1408635812-31584-5-git-send-email-steve.capper@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-5-git-send-email-steve.capper@linaro.org>
Message-ID: <20140827115137.GK6968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 04:43:30PM +0100, Steve Capper wrote:
> Activate the RCU fast_gup for ARM. We also need to force THP splits to
> broadcast an IPI s.t. we block in the fast_gup page walker. As THP
> splits are comparatively rare, this should not lead to a noticeable
> performance degradation.
> 
> Some pre-requisite functions pud_write and pud_page are also added.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
