From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 08 Jul 2011 15:49:35 +0400
Subject: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
In-Reply-To: <1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
	<1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
Message-ID: <4E16EECF.7030102@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08-07-2011 14:04, Jan Weitzel wrote:

> Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> ---
>   arch/arm/mach-omap2/Kconfig  |    5 +++++
>   arch/arm/mach-omap2/Makefile |    4 ++++
>   2 files changed, 9 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 19d5891..c6a2d43 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
[...]
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index b148077..e81b594 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -238,6 +238,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
>   					   hsmmc.o \
>   					   omap_phy_internal.o
>
> +obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \

    You need to first add board-omap4pcm049.c, and only then wire it to the 
Makefile. You could do both in onme patch though...

WBR, Sergei
