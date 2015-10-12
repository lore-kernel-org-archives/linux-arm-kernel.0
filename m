From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Oct 2015 17:38:01 +0100
Subject: [PATCH] arm64: atomics: implement native {relaxed, acquire,
 release} atomics
In-Reply-To: <1444331718-24036-1-git-send-email-will.deacon@arm.com>
References: <1444331718-24036-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151012163801.GE6320@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 08:15:18PM +0100, Will Deacon wrote:
> Commit 654672d4ba1a ("locking/atomics: Add _{acquire|release|relaxed}()
> variants of some atomic operation") introduced a relaxed atomic API to
> Linux that maps nicely onto the arm64 memory model, including the new
> ARMv8.1 atomic instructions.
> 
> This patch hooks up the API to our relaxed atomic instructions, rather
> than have them all expand to the full-barrier variants as they do
> currently.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Applied (fingers crossed ;)). Thanks.

-- 
Catalin
