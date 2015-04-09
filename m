From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Apr 2015 18:15:29 +0100
Subject: [PATCH 4/7] ARM: cache-v7: optimise branches in
 v7_flush_cache_louis
In-Reply-To: <E1YdzFA-0008Cr-Ku@rmk-PC.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <E1YdzFA-0008Cr-Ku@rmk-PC.arm.linux.org.uk>
Message-ID: <20150409171529.GH23861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 11:54:32AM +0100, Russell King wrote:
> Optimise the branches such that for the majority of unaffected devices,
> we avoid needing to execute the errata work-around code path by
> branching to start_flush_levels early.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
