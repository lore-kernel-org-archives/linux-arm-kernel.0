From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Aug 2012 12:22:04 +0100
Subject: [PATCH] ARM: OMAP2+: twl-common: Fix compile time error when
 omap-twl4030 audio is not enabled
In-Reply-To: <1345703701-27283-1-git-send-email-peter.ujfalusi@ti.com>
References: <1345703701-27283-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120823112204.GY7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 09:35:01AM +0300, Peter Ujfalusi wrote:
> Fixes:
> CC      arch/arm/mach-omap2/twl-common.o arch/arm/mach-omap2/twl-common.c:562: error: conflicting types for ?omap_twl4030_audio_init?
> arch/arm/mach-omap2/twl-common.h:62: error: previous declaration of ?omap_twl4030_audio_init? was here
> make[1]: *** [arch/arm/mach-omap2/twl-common.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> When building the kernel with !SND_OMAP_SOC_OMAP_TWL4030

Which branch needs this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/7367a41c/attachment.sig>
