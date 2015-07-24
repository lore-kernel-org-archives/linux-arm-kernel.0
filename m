From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 16:40:43 +0100
Subject: [PATCH v2 16/20] arm64: atomics: tidy up common atomic{,64}_*
 macros
In-Reply-To: <1437734531-10698-17-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-17-git-send-email-will.deacon@arm.com>
Message-ID: <20150724154043.GQ3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:42:07AM +0100, Will Deacon wrote:
> The common (i.e. identical for ll/sc and lse) atomic macros in atomic.h
> are needlessley different for atomic_t and atomic64_t.
> 
> This patch tidies up the definitions to make them consistent across the
> two atomic types and factors out common code such as the add_unless
> implementation based on cmpxchg.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
