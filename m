From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 8 May 2014 13:57:15 +0300
Subject: [PATCH 0/2] ARM: dts: Fix OMAP3 ISP functional clock configuration
In-Reply-To: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <536B630B.8010303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/14 13:41, Laurent Pinchart wrote:
> Hello,
> 
> This patch set enables rate propagation from the OMAP3 ISP functional clock to
> the DPLL4 M5 clock. It copies Tomi Valkeinen's similar patch set for the OMAP
> DSS functional clock from the "OMAP: OMAP3 DSS related clock patches" patch
> series.
> 
> Laurent Pinchart (2):
>   ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
>   ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path
> 
>  arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
>  arch/arm/boot/dts/omap3xxx-clocks.dtsi | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 

These look fine to me.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/209bba74/attachment.sig>
