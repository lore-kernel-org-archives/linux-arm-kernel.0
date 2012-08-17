From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Aug 2012 23:43:28 +0100
Subject: [PATCH 4/5] ASoC: Davinci: machine: Add device tree binding
In-Reply-To: <1344948125-5649-5-git-send-email-gururaja.hebbar@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-5-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120817224327.GK18871@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 06:12:04PM +0530, Hebbar, Gururaja wrote:

> +- ti,codec-clock : The Codec Clock from the board

I think this is the clock rate?  Please specify it more specifically.

> +"<CODEC DAI Name>",	"<true if evm_aic3x_init is required, else false>",
> +"<evm ops required, evm_ops or evm_spdif_ops>";

Please be more specific as to what these actually do - consider the user
who is reading the bindings with a view to implementing them for their
board, or writing drivers for another OS.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/ebff4c85/attachment.sig>
