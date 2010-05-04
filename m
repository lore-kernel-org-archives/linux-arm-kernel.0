From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 04 May 2010 16:05:35 +0100
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the 16-way
	PL310 (v3)
In-Reply-To: <1272985254-5675-2-git-send-email-jason.mcmullan@netronome.com>
References: <1272985254-5675-2-git-send-email-jason.mcmullan@netronome.com>
Message-ID: <1272985535.15948.6.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-04 at 16:00 +0100, Jason S. McMullan wrote:
> The L310 cache controller's interface is almost identical
> to the L210. One major difference is that the PL310 can
> have up to 16 ways.
> 
> This change uses the cache's part ID and the Assciativity
> bits in the AUX_CTRL register to determine the number of ways.
> 
> Also prints out the # of ways, CACHE_ID and AUX_CTRL registers.
> 
> Signed-off-by: Jason S. McMullan <jason.mcmullan@netronome.com>

Looks fine to me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
