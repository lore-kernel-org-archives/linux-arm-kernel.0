From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Mar 2014 09:02:30 -0700
Subject: [PATCH 51/75] ARM: l2c: remove platforms/SoCs setting early BRESP
In-Reply-To: <E1WTYYR-0007GJ-Ai@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYR-0007GJ-Ai@rmk-PC.arm.linux.org.uk>
Message-ID: <20140328160229.GF24308@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> Since we now automatically enable early BRESP in core L2C-310 code when
> we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
> explicitly.  Instead, they should seek to preserve the value of bit 30
> in the auxiliary control register.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
