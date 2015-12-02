From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 12:35:15 +0100
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
In-Reply-To: <20151202112109.342837c08019e632b28020fc@kernel.org>
References: <20151202112109.342837c08019e632b28020fc@kernel.org>
Message-ID: <3662441.U0Roeq6f5X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 11:21:09 Mark Brown wrote:
> 
> Today's linux-next merge of the renesas tree got a conflict in
> arch/arm/mach-shmobile/Kconfig between commit e32465429490 ("ARM: use "depends
> on" for SoC configs instead of "if" after prompt") from the arm-soc tree and
> commit 9b5ba0df4ea4f94 ("ARM: shmobile: Introduce ARCH_RENESAS") from the
> renesas tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

(as predicted by Simon ;-) )

I plan to put the cross-platform changes I have in next/cleanup into a separate
branch that can be pulled into other branches to resolve those issues.

	Arnd
