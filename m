From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 16 Oct 2018 09:21:36 +0200
Subject: [PATCH v5 0/2] Neutis N5 support
In-Reply-To: <1539604192-17561-1-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539604192-17561-1-git-send-email-aleksandr.aleksandrov@emlid.com>
Message-ID: <20181016072136.3belesnmrvbejiro@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 02:49:48PM +0300, Aleksandr Aleksandrov wrote:
> This patch addes Neutis N5 support.
> Emlid Neutis N5 is a SoM based on Allwinner H5.
> The patch includes device tree file for Dev board
> and dtsi file for SoM needs.
> 
> Changes from v1: separate dts file: dtsi for SoM
> and motherboard dts file that inlcudes dtsi file.
> 
> Changes from v2 (5 oct 2018):
> - makefile: dtb-$(CONFIG_ARCH_SUNXI) - ordered alphabetically
> 
> Changes from v3 (12 oct 2018):
> - fix commit prefix for 1/2 patch
> - use an SPDX header instead of the full license text
> - compatible: "emlid,neutis-n5" instead of "emlid,emlid-neutis-n5"
> 
> Changes from v4 (15 oct 2018):
> - fix dt-bindings commit prefix
> - update license header for dts files
> - make interfaces be alphabetically in devboard dts file

Queued both for 4.21, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
