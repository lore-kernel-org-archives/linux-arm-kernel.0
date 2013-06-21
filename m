From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 15:05:01 +0200
Subject: [GIT PULL 0/5] Renesas ARM-based SoC board updates for v3.11 #2
In-Reply-To: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
References: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <201306211505.01567.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following updates to the Bock-W board for v3.11.
> 
> This pull request is based on a merge of renesas-boards2-for-v3.11 and
> renesas-soc2-for-v3.11, both of which you have previously pulled, in order
> to satisfy dependencies.
> 
> 
> The following changes since commit 2e9a222e271b7fd16e62a0861ad5e42996d17815:
> 
>   Merge branch 'soc2' into boards-base (2013-06-13 14:41:53 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.11
> 
> for you to fetch changes up to 2c83322ce820bcf2d5e8265de831489076ee211e:
> 
>   ARM: shmobile: BOCK-W: change Ether device name (2013-06-18 16:22:45 +0900)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM-based SoC board updates for v3.11
> 
> * Extended hardware coverage for the Bock-W board
>   by Goda-san and Morimoto-san
> * Correction to Ether device name for the Bock-W board
>   from Sergei Shtylyov
> 
> ----------------------------------------------------------------
> Kuninori Morimoto (3):
>       ARM: shmobile: bockw: add I2C device support
>       ARM: shmobile: bockw: add SPI FLASH support
>       ARM: shmobile: bockw: add MMCIF support
> 
> Sergei Shtylyov (2):
>       ARM: shmobile: BOCK-W: add Ether support
>       ARM: shmobile: BOCK-W: change Ether device name
> 
>  arch/arm/mach-shmobile/board-bockw.c | 98 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
> 

Pulled into next/boards, thanks!

	Arnd
