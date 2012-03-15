From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 16:10:44 +0000
Subject: [GIT PULL][for v3.4] pull request from board-specific branch in
 arch-pxa
In-Reply-To: <CAN1soZyWmrzQzr0VHtrixdr2myv4ggJ1YBcS8OnuLJLOn2uVEQ@mail.gmail.com>
References: <CAN1soZyWmrzQzr0VHtrixdr2myv4ggJ1YBcS8OnuLJLOn2uVEQ@mail.gmail.com>
Message-ID: <201203151610.44491.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Haojian Zhuang wrote:
> Second, please help to pull these commits from arch-pxa git tree.
> 
> The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:
> 
>   Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)
> 
> are available in the git repository at:
>   git://github.com/hzhuang1/linux.git board-specific
> 
> Paul Parsons (3):
>       ARM: pxa/hx4700: Remove unwanted request for GPIO105
>       ARM: pxa/hx4700: Reduce sleep mode battery discharge by 35%
>       pxa/hx4700: Remove pcmcia platform_device structure
> 
>  arch/arm/mach-pxa/hx4700.c                  |   17 ++---------------
>  arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    2 ++
>  2 files changed, 4 insertions(+), 15 deletions(-)
> 

Pulled into next/boards,

Thanks!

	ARnd
