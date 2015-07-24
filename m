From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 12:15:57 +0100
Subject: [PATCH v2 03/20] arm64: cpufeature.h: add missing #include of
 kernel.h
In-Reply-To: <1437734531-10698-4-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-4-git-send-email-will.deacon@arm.com>
Message-ID: <20150724111557.GD3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:54AM +0100, Will Deacon wrote:
> cpufeature.h makes use of DECLARE_BITMAP, which in turn relies on the
> BITS_TO_LONGS and DIV_ROUND_UP macros.
> 
> This patch includes kernel.h in cpufeature.h to prevent all users having
> to do the same thing.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
