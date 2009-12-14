From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 10:21:26 +0000
Subject: [RFC PATCH 1/2] ARM: cache-l2x0: avoid taking spinlock for
	every iteration
In-Reply-To: <E1NJVwt-0006uj-11@rmk-PC.arm.linux.org.uk>
References: <E1NJVwt-0006uj-11@rmk-PC.arm.linux.org.uk>
Message-ID: <1260786086.17159.13.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-12-12 at 17:40 +0000, Russell King - ARM Linux wrote:
> Taking the spinlock for every iteration is very expensive; instead,
> batch iterations up into 4K blocks, releasing and reacquiring the
> spinlock between each block.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

It looks fine to me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
