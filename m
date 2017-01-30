From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:37:08 -0800
Subject: [GIT PULL] pxa for v4.11
In-Reply-To: <87bmuub1hk.fsf@belgarion.home>
References: <87bmuub1hk.fsf@belgarion.home>
Message-ID: <20170130013708.GJ3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 10:43:19AM +0100, Robert Jarzmik wrote:
> 
> Hello Arnd, Kevin, Olof,
> 
> Please consider this pull request for pxa 4.11 cycle, which is a very tiny one.
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-for-4.11
> 
> for you to fetch changes up to d9bd264596b9ec364990ab64c8cc1792586425e3:
> 
>   MAINTAINERS: transfer maintainership for the EZX platform (2017-01-26 09:52:51 +0100)
> 
> ----------------------------------------------------------------
> This is the pxa changes for v4.11 cycle.
> 
> This cycle is a minor fixes one, covering :
>  - build fixes from Arnd, mainly include related
>  - transfer of maintainance of Motorala phone to Robert
> 
> ----------------------------------------------------------------
> Arnd Bergmann (2):
>       ARM: pxa: ezx: fix a910 camera data
>       ARM: pxa: include linux/leds.h
> 
> Stefan Schmidt (1):
>       MAINTAINERS: transfer maintainership for the EZX platform
> 
>  MAINTAINERS             |  8 ++-----
>  arch/arm/mach-pxa/ezx.c | 56 ++++++++++++++++++++++++++-----------------------
>  arch/arm/mach-pxa/idp.c |  1 +
>  3 files changed, 33 insertions(+), 32 deletions(-)
> 

Merged, thanks!


-Olof
