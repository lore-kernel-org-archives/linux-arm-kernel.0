From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Apr 2013 22:45:46 +0900
Subject: [PATCH 2/2] ARM: shmobile: BOCK-W: enable I2C in defconfig
In-Reply-To: <516FF561.5040801@cogentembedded.com>
References: <201304172242.27671.sergei.shtylyov@cogentembedded.com>
 <201304172247.28311.sergei.shtylyov@cogentembedded.com>
 <20130418132724.GC20929@verge.net.au>
 <516FF561.5040801@cogentembedded.com>
Message-ID: <20130418134546.GJ20929@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 05:30:09PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 18-04-2013 17:27, Simon Horman wrote:
> 
> >>From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> >>Enable I2C driver in 'bockw_defconfig'.
> 
> >>Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>---
> >>  arch/arm/configs/bockw_defconfig |    2 ++
> >>  1 file changed, 2 insertions(+)
> 
> >>Index: renesas/arch/arm/configs/bockw_defconfig
> >>===================================================================
> >>--- renesas.orig/arch/arm/configs/bockw_defconfig
> >>+++ renesas/arch/arm/configs/bockw_defconfig
> >>@@ -73,6 +73,8 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=6
> >>  CONFIG_SERIAL_SH_SCI_CONSOLE=y
> >>  # CONFIG_HW_RANDOM is not set
> >>  # CONFIG_HWMON is not set
> >>+CONFIG_I2C=y
> >>+CONFIG_I2C_RCAR=y
> >>  CONFIG_USB=y
> >>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> >>  CONFIG_USB_EHCI_HCD=y
> 
> >I have applied the following after resolving conflicts
> >(I don't see CONFIG_USB=y in my tree). Please let me
> >know if I made an error.
> 
>    I wrote in [0/2] that the patch is atop of my unaccepted USB patches.
> 
> >I have queued-up the change for v3.11 in the defconfig-bockw branch
> >and will push is shortly.
> 
>    Have you also queued patch #1? The patch #2 doesn't make much
> sense without it.

No, I was going to ask for it to be rebased, but I'm happy for it
to wait until your USB changes go in if you are happy to wait.

As for not making much sense, I'm happy with pre-emptively applying
defconfig changes as they are somewhat orthogonal and live in a different
branch.
