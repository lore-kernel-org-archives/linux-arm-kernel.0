From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 14 May 2010 09:46:19 -0400 (EDT)
Subject: Git pull request: Orion/Kirkwood stuff for 2.6.35
In-Reply-To: <alpine.LFD.2.00.1005031731010.14468@xanadu.home>
References: <alpine.LFD.2.00.1005031731010.14468@xanadu.home>
Message-ID: <alpine.LFD.2.00.1005140945410.31272@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

On Mon, 3 May 2010, Nicolas Pitre wrote:

> 
> Russell, could you pull:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git master
> 
> This contains what I have pending for Orion/Kirkwood so far.  Since I'm 
> not working at Marvell anymore, I'm using a different server for this 
> pull request.  If anyone at Marvell is willing to maintain this tree 
> I'll be happy to pass the baton.  Otherwise I'll just collect patches 
> but I don't expect to work much on it myself (this code is in 
> maintenance mode anyway).
> 
> Arnaud Patard (1):
>       [ARM] dns323-setup.c: fix WARN() when booting
> 
> Nicolas Pitre (1):
>       update MAINTAINERS file
> 
> Siddarth Gore (1):
>       [ARM] Kirkwood: Marvell GuruPlug support
> 
> Simon Guinot (3):
>       [ARM] Kirkwood: add LaCie 2Big Network v2 support
>       [ARM] Kirkwood: add LaCie 5Big Network v2 support
>       [ARM] Kirkwood: merge net2big_v2 and net5big_v2 board setups
> 
>  MAINTAINERS                               |   12 +-
>  arch/arm/mach-kirkwood/Kconfig            |   18 +
>  arch/arm/mach-kirkwood/Makefile           |    3 +
>  arch/arm/mach-kirkwood/guruplug-setup.c   |  131 +++++++
>  arch/arm/mach-kirkwood/netxbig_v2-setup.c |  415 +++++++++++++++++++++++
>  arch/arm/mach-orion5x/dns323-setup.c      |    1 +
>  6 files changed, 574 insertions(+), 6 deletions(-)
> 
> 
> Nicolas
> 
