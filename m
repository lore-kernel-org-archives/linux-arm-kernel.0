From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 22:51:39 +0200
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
Message-ID: <201110072251.40028.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 September 2011, Will Deacon wrote:
> 
> Hi Arnd,
> 
> Please pull these DEBUG_LL platform updates for 3.2. You can find the core
> updates (actually all resident in arch/arm/Kconfig.debug) in Russell's
> for-next branch.
> 
> I think Stephen Boyd was planning to move MSM to the new code as well, but
> I've not seen any code yet so I guess that can go in later.

Hi Will,

I've tried to pull this branch, but I'm getting conflicts with patches
from the 'CPU mapping platform updates' series you sent me earlier.
Any idea what's going on there?

I can certainly fix up the conflicts, but my feeling is that there is
something wrong on your side and one of the two branches contains
stuff from a stale version of Russell's tree.

	Arnd
