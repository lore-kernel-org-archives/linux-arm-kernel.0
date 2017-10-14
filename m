From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Oct 2017 00:32:54 +0200
Subject: [PATCH 0/2] Introduce new DT files for Meson-AXG SoC
In-Reply-To: <20171013231313.22850-1-dlan@gentoo.org>
References: <20171013231313.22850-1-dlan@gentoo.org>
Message-ID: <1886d509-297c-62a1-9c34-13d83e18bb65@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.10.2017 um 01:13 schrieb Yixun Lan:
> This attempt will try to add new DT files to support Meson-AXG SoC.
> Due to the AXG series has new memory layout, we decide to start a new
> DT structure without sharing with previous meson-gx.dtsi
> 
> 1) in the first patch, we try to document the new Meson-AXG bindings
> 2) in the second patch, we try to bring up a minimal serial console,
> so it's capable of running a minimal system (in ramdisk).
> 
> 
> Yixun Lan (2):
>   dt-bindings: arm: amlogic: Add Meson AXG binding
>   arm64: dts: meson-axg: add initial A113D SoC DT support

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
