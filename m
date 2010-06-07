From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Jun 2010 12:39:10 +0100
Subject: [PATCH v2] pxa/z2: Add regulator support
In-Reply-To: <1275883143-3512-1-git-send-email-marek.vasut@gmail.com>
References: <1275883143-3512-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100607113910.GC5993@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 05:59:03AM +0200, Marek Vasut wrote:

> +	}, {
> +		.constraints = {
> +			.name		= "LDO1",
> +			.min_uV		= 1000000,
> +			.max_uV		= 3150000,
> +			.always_on	= 1,
> +		},
> +	}, {
> +		.constraints = {
> +			.name		= "LDO2",
> +			.min_uV		= 1050000,
> +			.max_uV		= 3300000,
> +			.always_on	= 1,
> +		},
> +	}

Are you *sure* that the voltages for these regulators can be varied this
much (especailly given that there are no consumers set up)?
