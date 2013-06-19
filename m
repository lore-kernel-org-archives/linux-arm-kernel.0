From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 19 Jun 2013 11:02:24 +0100
Subject: [GIT PULL] picoxcell cleanups for 3.11
In-Reply-To: <20130611122621.GA9967@page>
References: <20130611122621.GA9967@page>
Message-ID: <20130619100224.GB8641@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing Arnd's mail address (sorry!).

Jamie

On Tue, Jun 11, 2013 at 01:26:21PM +0100, Jamie Iles wrote:
> Hi Arnd, Olof,
> 
> Please pull these small changes for 3.11 to cleanup the picoxcell machine
> support.
> 
> Thanks,
> 
> Jamie
> 
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/jamieiles/linux-2.6-ji.git picoxcell-next
> 
> for you to fetch changes up to 4b83f75a7af388aaf5f79ccf72c37074bc9166da:
> 
>   ARM: picoxcell: Remove init_irq declaration in machine description (2013-05-14 17:19:12 +0100)
> 
> ----------------------------------------------------------------
> Jamie Iles (1):
>       picoxcell: remove redundant common.h
> 
> Maxime Ripard (1):
>       ARM: picoxcell: Remove init_irq declaration in machine description
> 
>  arch/arm/mach-picoxcell/common.c |  7 -------
>  arch/arm/mach-picoxcell/common.h | 17 -----------------
>  2 files changed, 24 deletions(-)
>  delete mode 100644 arch/arm/mach-picoxcell/common.h
