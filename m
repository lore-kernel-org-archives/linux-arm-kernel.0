From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 20:40:39 +0000
Subject: [GIT PULL] ARM: orion/dove: v3.4 fixes
In-Reply-To: <20120514182722.GM16338@titan.lakedaemon.net>
References: <20120514182722.GM16338@titan.lakedaemon.net>
Message-ID: <201205142040.39929.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2012, Jason Cooper wrote:
> The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:
> 
>   Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/jcooper/linux.git orion_fixes_for_v3.4
> 
> Alexander Clouter (5):
>       crypto: mv_cesa requires on CRYPTO_HASH to build
>       ARM: orion5x: ts78xx whitespace cleanups
>       ARM: orion5x: ts78xx fix NAND resource off by one
>       ARM: orion5x: remove PM dependency from ts78xx
>       ARM: orion5x: ts78xx debugging changes
> 
> Andrew Lunn (3):
>       Orion5x: Fix warning: struct pci_dev declared inside paramter list
>       Orion5x: Fix Section mismatch warnings
>       Dove: Fix Section mismatch warnings
> 
> Jason Cooper (1):
>       Merge branch 'v3.4-rc6-cleanup-v2' of git://github.com/lunn/linux
> into orion_fixes_for_v3.4
> 


Pulled into next/fixes, thanks!

I noticed that none of these are tagged for inclusion into stable. Is that
intentional? When sending bug fixes, please make sure that each patch that
you want to get applied on older kernel versions contains a
'Cc: stable at vger.kernel.org' line!

	Arnd
