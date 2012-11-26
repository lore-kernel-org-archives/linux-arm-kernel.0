From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Nov 2012 11:56:19 +0000
Subject: [PATCH 2/2] ASoC: Davinci: machine: Add device tree binding
In-Reply-To: <1353557099-21599-3-git-send-email-gururaja.hebbar@ti.com>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
 <1353557099-21599-3-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20121126115619.GF9411@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 09:34:59AM +0530, Hebbar, Gururaja wrote:

> +- dai-data		: A list of DAI data used by SOC code to register
> +			  DAI, Codecs platform.
> +			  The string index "should" be as shown below.
> +dai-data =
> +"<DAI Name>", 		"<DAI Stream Name>",
> +"<CODEC DAI Name>",	"<true if evm_aic3x_init is required, else false>",
> +"<evm ops required (evm_ops or evm_spdif_ops)>";

This continues to have the same issue as with previous versions, this is
all Linux internals (especially the evm_aic3x_init thing) not a
description of the hardware, there's not enough information to allow
someone to work out what the bindings for their system should be.

Do not post *ANY* further versions that have this evm_aic3x_init stuff
in them, it's very annoying that you keep on ignoring this feedback.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/1d789485/attachment-0001.sig>
