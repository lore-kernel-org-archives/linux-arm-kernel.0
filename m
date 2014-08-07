From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Aug 2014 18:27:19 +0100
Subject: [PATCH v3 1/2] arm64: add helper functions to read I-cache
 attributes
In-Reply-To: <1407339966-29351-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1407339966-29351-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140807172719.GE31101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 04:46:05PM +0100, Ard Biesheuvel wrote:
> This adds helper functions and #defines to <asm/cachetype.h> to read the
> line size and the number of sets from the level 1 instruction cache.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v3: add WARN_ON(preemptible()), move icache_get_ccsidr() to cpuinfo.c to
>     prevent #include header recursion hell
> v2: put () around macro args, use 64-bit types for asm() mrs/msr calls
> 
>  arch/arm64/include/asm/cachetype.h | 20 ++++++++++++++++++++
>  arch/arm64/kernel/cpuinfo.c        | 14 ++++++++++++++
>  2 files changed, 34 insertions(+)

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
