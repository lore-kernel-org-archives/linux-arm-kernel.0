From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Aug 2012 20:34:14 +0100
Subject: [PATCH 1/4] arm/dts: max77686: Add DTS file for max77686 PMIC
In-Reply-To: <1344366267-18971-1-git-send-email-dongjin.kim@agreeyamobility.net>
References: <1344366267-18971-1-git-send-email-dongjin.kim@agreeyamobility.net>
Message-ID: <20120807193413.GE14711@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 04:04:11AM +0900, Dongjin Kim wrote:

> +			buck1 {
> +				regulator-compatible = "BUCK1";
> +				regulator-name = "VDD_MIF_1.0V";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1050000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};

These settings for the regulators are clearly specific to the board
rather than the device so should be in the board file.
