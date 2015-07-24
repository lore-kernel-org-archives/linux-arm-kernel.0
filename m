From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 12:26:44 +0100
Subject: [PATCH v2 06/20] arm64: alternatives: add cpu feature for lse
 atomics
In-Reply-To: <1437734531-10698-7-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-7-git-send-email-will.deacon@arm.com>
Message-ID: <20150724112643.GG3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:57AM +0100, Will Deacon wrote:
> Add a CPU feature for the LSE atomic instructions, so that they can be
> patched in at runtime when we detect that they are supported.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
