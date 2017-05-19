From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 12:31:16 +0100
Subject: [RFC PATCH] arm64: neon: Remove support for nested or hardirq
 kernel-mode NEON
In-Reply-To: <1495193199-1291-1-git-send-email-Dave.Martin@arm.com>
References: <1495193199-1291-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170519113113.GC3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 12:26:39PM +0100, Dave Martin wrote:

[...]

> I've build-tested this only for now: no runtime testing, no
> benchmarking.

Note, there's a missing #include of <asm/neon.h> from fpsimd.c.
(I moved/renamed kernel_neon_allowed() after build-testing...)

[...]

Cheers
---Dave
