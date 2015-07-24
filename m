From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 16:45:19 +0100
Subject: [PATCH v2 20/20] arm64: kconfig: select HAVE_CMPXCHG_LOCAL
In-Reply-To: <1437734531-10698-21-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-21-git-send-email-will.deacon@arm.com>
Message-ID: <20150724154519.GU3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:42:11AM +0100, Will Deacon wrote:
> We implement an optimised cmpxchg_local macro, so let the kernel know.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
