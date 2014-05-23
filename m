From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 24 May 2014 00:06:33 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.16 (incr. #2)
In-Reply-To: <20140522155123.GT8664@titan.lakedaemon.net>
References: <20140522155123.GT8664@titan.lakedaemon.net>
Message-ID: <201405240006.33940.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014, Jason Cooper wrote:
> The following changes since commit 208f4e0d9bce775fbc7ab08c830d135d3da5777c:
> 
>   ARM: multi_v5_defconfig: Enable sound modules needed for t5325 (2014-05-05 01:22:11 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.16-2
> 
> for you to fetch changes up to 0105c9990291587a3b1fecb576f4d9b6728f1191:
> 
>   ARM: mvebu: enable MSI support in mvebu_v7_defconfig (2014-05-22 14:22:17 +0000)

As discussed with Olof, I'm starting a new next/defconfig branch separate
from next/boards now, and have merged this one into the new branch.

Still need to figure out how to separate the defconfig changes that are
already in next/boards from the rest there, but since this one includes
the other changes, we're good for mvebu.

	Arnd
