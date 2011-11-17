From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 16 Nov 2011 19:15:55 -0500 (EST)
Subject: [PATCH] ARM: Use PMD_SHIFT instead of PGDIR_SHIFT in
 dma-consistent.c
In-Reply-To: <20111116235941.GI9581@n2100.arm.linux.org.uk>
References: <1321461495-2860-1-git-send-email-catalin.marinas@arm.com>
 <20111116235941.GI9581@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111161911530.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Nov 2011, Russell King - ARM Linux wrote:

> On Wed, Nov 16, 2011 at 04:38:15PM +0000, Catalin Marinas wrote:
> > Commit 99d1717d introduces dynamic allocation of the consistent_pte
> 
> Always include the commit summary when quoting the commit ID.  Shortened
> commit IDs aren't guaranteed to remain unique for any amount of time, and
> so become ambiguous (and actually more difficult to locate when that
> happens.)

Or at least provide more than the minimum amount of SHA1 characters to 
describe the commit.  Something like 12 or more characters is likely to 
remain unambiguous for a couple decades.


Nicolas
