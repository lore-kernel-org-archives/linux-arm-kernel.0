From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 16:32:57 +0100
Subject: [PATCH v2 15/20] arm64: cmpxchg: avoid memory barrier on
 comparison failure
In-Reply-To: <1437734531-10698-16-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-16-git-send-email-will.deacon@arm.com>
Message-ID: <20150724153256.GP3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:42:06AM +0100, Will Deacon wrote:
> cmpxchg doesn't require memory barrier semantics when the value
> comparison fails, so make the barrier conditional on success.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
