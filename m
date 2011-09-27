From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Sep 2011 13:16:22 +0100
Subject: [PATCH 5/9] regulator: helper routine to extract
	fixed_voltage_config
In-Reply-To: <1317118372-17052-6-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-6-git-send-email-rnayak@ti.com>
Message-ID: <20110927121622.GD4289@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 03:42:48PM +0530, Rajendra Nayak wrote:
> The helper routine of_get_fixed_voltage_config() extracts
> fixed_voltage_config structure contents from device tree.
> 
> Also add documenation for additional bindings for fixed
> regulators that can be passed through dt.

Why not just add device tree support into the driver directly?

> +Optional properties:
> +- regulator-fixed-supply: Name of the regulator supply

This is going to be confusing with respect to the generic regulator
supply property.

> +- regulator-fixed-enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low

Word wrap for legibility please.
