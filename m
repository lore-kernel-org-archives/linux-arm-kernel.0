From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 12:37:24 +0300
Subject: [PATCH v3 0/3] Add display support for gta04 device
In-Reply-To: <1399580212-5183-1-git-send-email-marek@goldelico.com>
References: <1399580212-5183-1-git-send-email-marek@goldelico.com>
Message-ID: <536CA1D4.6010605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 23:16, Marek Belisko wrote:
> This 3 patches adding display support for openmoko gta04 device.
> First patch add DT bindings for topolly td028 panel. Second add description for
> dss + panel and third fix panel probing when panel is compiled as module.
> 
> Changes from v2:
> - add missing 'port' node for dpi_out endpoint (comment from Tomi Valkeinen)
> 
> Changes from v1:
> - extend panel compatible string by 'omapdss'
> - add tpo-td028 panel to dss_compat_conv_list
> - add MODULE_ALIAS macro to properly probe panel when is compiled as module
> 
> Marek Belisko (3):
>   omapdss: panel-tpo-td028ec1: Add DT support.
>   ARM: dts: oma3-gta04: Add display support
>   omapdss: panel-tpo-td028ec1: Add module alias
> 
>  .../bindings/video/toppoly,td028ttec1.txt          | 30 ++++++++
>  arch/arm/boot/dts/omap3-gta04.dts                  | 87 ++++++++++++++++++++++
>  arch/arm/mach-omap2/display.c                      |  1 +
>  .../omap2/displays-new/panel-tpo-td028ttec1.c      | 33 +++++++-
>  4 files changed, 150 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/video/toppoly,td028ttec1.txt
> 

I think this series looks fine. I'll pick it up.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/24da857c/attachment.sig>
