From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Nov 2011 17:53:12 -0700
Subject: [GIT PULL v3] ARM: OMAP: Cortex-A9 PERIPHCLK node for 3.2
In-Reply-To: <alpine.DEB.2.00.1110101840440.5205@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110101342010.5205@utopia.booyaka.com>
	<alpine.DEB.2.00.1110101415560.5205@utopia.booyaka.com>
	<alpine.DEB.2.00.1110101840440.5205@utopia.booyaka.com>
Message-ID: <20111105005312.GQ31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111010 17:09]:
> Hi Tony
> 
> The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> 
>   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 clock_hwmod_devel_3.2
> 
> This pull request drops the EHCI/OHCI hwmod data due to some 
> inconsistencies that were just found in the data.
> 
> Santosh Shilimkar (1):
>       ARM: OMAP4: clock: Add CPU local timer clock node.
> 
>  arch/arm/mach-omap2/clock44xx_data.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Should this be pulled into fixes for v3.2 -rc cycle?

Tony
