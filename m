From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Jan 2013 12:26:12 +0000
Subject: [PATCH V2 2/2] ASoC: Davinci: machine: Add device tree binding
In-Reply-To: <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20130104122612.GM4627@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 03:24:37PM +0530, Hebbar Gururaja wrote:

> +		"MIC3L",                "Mic Bias 2V",
> +		"MIC3R",                "Mic Bias 2V",
> +		"Mic Bias 2V",          "Mic Jack",

The CODEC driver biases should be changed over to be supplies, this
makes the above much more natural - the routing there is a hack for
older versions of ASoc.  Otherwise this looks fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130104/2b3dc923/attachment.sig>
