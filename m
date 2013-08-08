From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 Aug 2013 10:53:45 -0400
Subject: [PATCHv3 9/9] ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into
 OMAP builds
In-Reply-To: <1375811376-49985-10-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-10-git-send-email-d-gerlach@ti.com>
Message-ID: <5203B0F9.9090603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> With all the requisite changes in place we can now
> enable the basic PM support for AM335x. This patch
> updates the various OMAP files to enable suspend-resume
> on AM335x.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig         |    7 +++++--
>  arch/arm/mach-omap2/Makefile        |    2 ++
>  arch/arm/mach-omap2/board-generic.c |    1 +
>  arch/arm/mach-omap2/common.h        |   10 ++++++++++
>  arch/arm/mach-omap2/io.c            |    5 +++++
>  arch/arm/mach-omap2/pm.c            |    3 ++-
>  arch/arm/mach-omap2/pm.h            |    5 +++++
>  arch/arm/mach-omap2/sram.c          |   10 +++++++++-
>  arch/arm/mach-omap2/sram.h          |    2 ++
>  9 files changed, 41 insertions(+), 4 deletions(-)
> 
The patch looks fine but too many changes in one patch
than my liking. No strong preference though.

Acked-by: Santosh Shilikar<santosh.shilimkar@ti.com>
