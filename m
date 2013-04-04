From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 04 Apr 2013 12:24:15 +0200
Subject: [PATCH 00/04] ARM: shmobile: pinmux platform device cleanups
In-Reply-To: <20130403063246.2500.65318.sendpatchset@w520>
References: <20130403063246.2500.65318.sendpatchset@w520>
Message-ID: <11100532.ubSdK9L5P1@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thanks for the patches.

On Wednesday 03 April 2013 15:32:46 Magnus Damm wrote:
> ARM: shmobile: pinmux platform device cleanups
> 
> [PATCH 01/04] ARM: shmobile: r8a7740 pinmux platform device cleanup
> [PATCH 02/04] ARM: shmobile: r8a7779 pinmux platform device cleanup
> [PATCH 03/04] ARM: shmobile: sh7372 pinmux platform device cleanup
> [PATCH 04/04] ARM: shmobile: sh73a0 pinmux platform device cleanup
> 
> This series simply cleans up the pinmux platform device handling
> to save a couple of lines. Compile time tested on each SoC.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Except for 2/4,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  Written against renesas-next-20130403 in renesas.git
> 
>  arch/arm/mach-shmobile/setup-r8a7740.c |   24 +++++-------------------
>  arch/arm/mach-shmobile/setup-r8a7779.c |   19 ++++---------------
>  arch/arm/mach-shmobile/setup-sh7372.c  |   24 +++++-------------------
>  arch/arm/mach-shmobile/setup-sh73a0.c  |   25 ++++++-------------------
>  4 files changed, 20 insertions(+), 72 deletions(-)

-- 
Regards,

Laurent Pinchart
