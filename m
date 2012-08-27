From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 11:19:40 -0700
Subject: [PATCH V2 5/6] ASoC: Davinci: machine: Add device tree binding
In-Reply-To: <1346074004-22172-6-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-6-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120827181939.GX4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 06:56:43PM +0530, Hebbar, Gururaja wrote:
> Device tree support for tlv320aic3x CODEC driver

Not really for the CODEC - this is a machine driver.

> +- dai-data		: A list of DAI data used by SOC code to register
> +			  DAI, Codecs platform.
> +			  The string index "should" be as shown below.
> +dai-data =
> +"<DAI Name>", 		"<DAI Stream Name>",
> +"<CODEC DAI Name>",	"<true if evm_aic3x_init is required, else false>",
> +"<evm ops required (evm_ops or evm_spdif_ops)>";

What do these different ops do - how would the user figure it out or if
they're needed at all?
