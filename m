From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Aug 2012 23:45:13 +0100
Subject: [PATCH 5/5] ASoC: tlv320aic3x: Add device tree bindings
In-Reply-To: <1344948125-5649-6-git-send-email-gururaja.hebbar@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-6-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120817224512.GL18871@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 06:12:05PM +0530, Hebbar, Gururaja wrote:

> +- gpio-reset - <int> -  gpio pin number used for codec reset

This should be a standard DT GPIO reference by phandle like:

	gpio = <&gpio1 16 0>;

There's quite a few examples in tree.

Otherwise this looks good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/3927f7bd/attachment.sig>
