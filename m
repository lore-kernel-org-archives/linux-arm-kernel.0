From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 22:07:34 +0000
Subject: [GIT PULL][for 3.10] pull request from hi3xxx branch in pxa git
 tree
In-Reply-To: <CAN1soZwU34C8K1eShDU4hY5-39AWEg2Sb=mBopMHX9+zg6KVqw@mail.gmail.com>
References: <CAN1soZwU34C8K1eShDU4hY5-39AWEg2Sb=mBopMHX9+zg6KVqw@mail.gmail.com>
Message-ID: <201303152207.35091.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Haojian Zhuang wrote:
> Please help to pull armsoc/hi3xxx branch from pxa git tree. Since
> these patches are
> relied on Rob's sp804 implementation. I submitted all of them into my
> git tree too.

Hmm, I believe the sp804 patches are still under discussion, or they are
getting merged through the clocksource tree.

Either way, I don't have the dependencies in the arm-soc tree yet, I only
have

Rob Herring (4):
      clocksource: add empty version of clocksource_of_init
      clocksource: pass DT node pointer to init functions
      clocksource: tegra20: use the device_node pointer passed to init
      ARM: smp_twd: convert to use CLKSRC_OF init

which Rob submitted earlier. Rob, what is your plan for the sp804 patches?

	Arnd
