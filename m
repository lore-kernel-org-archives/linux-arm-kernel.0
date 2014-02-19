From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Feb 2014 17:05:45 +0000
Subject: [PATCH 2/2] arm64: asm: remove redundant "cc" clobbers
In-Reply-To: <1391516953-14541-2-git-send-email-will.deacon@arm.com>
References: <1391516953-14541-1-git-send-email-will.deacon@arm.com>
 <1391516953-14541-2-git-send-email-will.deacon@arm.com>
Message-ID: <20140219170544.GF22252@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 12:29:13PM +0000, Will Deacon wrote:
> cbnz/tbnz don't update the condition flags, so remove the "cc" clobbers
> from inline asm blocks that only use these instructions to implement
> conditional branches.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
