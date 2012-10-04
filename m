From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Oct 2012 07:01:10 +0000
Subject: linux-next: manual merge of the signal tree with the modules and
 arm-soc trees
In-Reply-To: <20121004145241.fac039e78a15bb614cbd6da0@canb.auug.org.au>
References: <20121004145241.fac039e78a15bb614cbd6da0@canb.auug.org.au>
Message-ID: <201210040701.10636.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 October 2012, Stephen Rothwell wrote:
> Hi Al,
> 
> Today's linux-next merge of the signal tree got conflicts in
> arch/avr32/include/asm/Kbuild, arch/cris/include/asm/Kbuild,
> arch/frv/include/asm/Kbuild, arch/h8300/include/asm/Kbuild,
> arch/ia64/include/asm/Kbuild, arch/m32r/include/asm/Kbuild,
> arch/microblaze/include/asm/Kbuild, arch/mn10300/include/asm/Kbuild and
> arch/xtensa/include/asm/Kbuild between commit e7a570ff7dff ("asm-generic:
> Add default clkdev.h") from the arm-soc tree, commit 786d35d45cc4 ("Make
> most arch asm/module.h files use asm-generic/module.h") from the modules
> tree and commit ddd03a1f7591 ("get rid of generic instances of
> asm/exec.h") from the signal tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Thanks for the three fixups. I was aware the conflicts would happen, but
your solutions are all correct. I had promised ot Mark a long time ago
to merge his patch and never actually done it.

My plan right now is to send the pull request after the other changes
have gone in and it's been in linux-next without new complaints for
a few days. The patch itself is very simple and should be harmless.

	Arnd
