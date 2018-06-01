From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jun 2018 16:11:39 +0100
Subject: [PATCH v6 0/2] arm64: signal: Report signal frame size to
 userspace via auxv
In-Reply-To: <1527847814-22829-1-git-send-email-Dave.Martin@arm.com>
References: <1527847814-22829-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180601151139.w2nj3oufty7cpzzo@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 11:10:12AM +0100, Dave P Martin wrote:
> This series adds support for telling userspace the size of the signal
> frame via a new AT_MINSIGSTKSZ entry in the aux vector.
> 
> This is an update to [1].  An omitted AT_MINSIGSTKSZ is now replaced
> with an AT_IGNORE entry instead of being collapsed out of the auxv
> entirely.
> 
> See individual patches for the delta.
> 
> [1] [PATCH v5 0/2] arm64: signal: Report signal frame size to userspace via auxv
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580974.html
> 
> 
> Dave Martin (2):
>   arm64/sve: Thin out initialisation sanity-checks for sve_max_vl
>   arm64: signal: Report signal frame size to userspace via auxv

Queued for 4.18. Thanks.

-- 
Catalin
