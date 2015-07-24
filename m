From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 16:44:36 +0100
Subject: [PATCH v2 18/20] arm64: atomics: implement atomic{, 64}_cmpxchg
 using cmpxchg
In-Reply-To: <1437734531-10698-19-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-19-git-send-email-will.deacon@arm.com>
Message-ID: <20150724154436.GS3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:42:09AM +0100, Will Deacon wrote:
> We don't need duplicate cmpxchg implementations, so use cmpxchg to
> implement atomic{,64}_cmpxchg, like we do for xchg already.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
