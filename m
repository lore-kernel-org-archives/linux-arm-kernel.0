From: balbi@ti.com (Felipe Balbi)
Date: Fri, 13 Jun 2014 11:23:13 -0500
Subject: [PATCH 0/2] Add support for am437x StarterKit
In-Reply-To: <1402676147-3711-1-git-send-email-balbi@ti.com>
References: <1402676147-3711-1-git-send-email-balbi@ti.com>
Message-ID: <20140613162313.GG8319@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing Benoit's address

On Fri, Jun 13, 2014 at 11:15:45AM -0500, Felipe Balbi wrote:
> Hi,
> 
> The following two patches (one of which is a resend from a patch which has been
> pending since May 19th!) enable AM437x StarterKit to boot in mainline.
> 
> Patches have been tested on top of 27a4e439fe5cd92b70137ae237c7aa6888c07b5a
> (next-20140610). With these we even have X with I3 running on this board, with
> audio, touchscreen, networking, blinky leds and others.
> 
> Felipe Balbi (1):
>   arm: dts: add support for AM437x StarterKit
> 
> Sathya Prakash M R (1):
>   ARM: AM43xx: hwmod: add DSS hwmod data
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am437x-sk-evm.dts                | 539 +++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  98 ++++
>  arch/arm/mach-omap2/prcm43xx.h                     |   1 +
>  5 files changed, 642 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am437x-sk-evm.dts
> 
> -- 
> 2.0.0.rc1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140613/986cfedc/attachment.sig>
