From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Nov 2011 10:29:06 +0000
Subject: [GIT PULL] Missing CPU mapping updates
In-Reply-To: <20111116113636.GH4942@mudshark.cambridge.arm.com>
References: <20111116113636.GH4942@mudshark.cambridge.arm.com>
Message-ID: <20111121102906.GA2437@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Wed, Nov 16, 2011 at 11:36:36AM +0000, Will Deacon wrote:
> Highbank and IMX6 were merged recently and therefore missed out on the
> logical CPU mapping updates. I've fixed them up in the branch below - please
> pull!

I'd like these to go in for 3.2, so please can you pull them into arm-soc?
Sorry to pester, but in Prague you said that's what you wanted us to do!

Will

> The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
> 
>   Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-arnd
> 
> Will Deacon (2):
>       ARM: highbank: convert logical CPU numbers to physical numbers
>       ARM: mach-imx: convert logical CPU numbers to physical numbers
> 
>  arch/arm/mach-highbank/highbank.c |    4 ++++
>  arch/arm/mach-imx/src.c           |    7 +++++++
>  2 files changed, 11 insertions(+), 0 deletions(-)
