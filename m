From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Apr 2015 18:20:39 +0100
Subject: [PATCH 5/7] ARM: cache-v7: optimise test for Cortex A9 r0pX
 devices
In-Reply-To: <E1YdzFF-0008Cv-OH@rmk-PC.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <E1YdzFF-0008Cv-OH@rmk-PC.arm.linux.org.uk>
Message-ID: <20150409172039.GJ23861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 11:54:37AM +0100, Russell King wrote:
> Eliminate one unnecessary instruction from this test by pre-shifting
> the Cortex A9 ID - we can shift the actual ID in the teq instruction
> thereby losing the pX bit of the ID at no cost.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
