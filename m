From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:03:06 +0100
Subject: [PATCH v2 3/4] ARM: mm: HugeTLB support for LPAE systems.
In-Reply-To: <1369323080-9673-4-git-send-email-steve.capper@linaro.org>
References: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
 <1369323080-9673-4-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524110306.GC18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 04:31:19PM +0100, Steve Capper wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> This patch adds support for hugetlbfs based on the x86 implementation.

Can we not share the x86 code as you are proposing for arm64 already?

-- 
Catalin
