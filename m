From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 31 Oct 2011 13:14:17 -0700
Subject: [PATCH 3/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <855f09f77c03a9f081818a03effdbd3bf7a30c91.1320088857.git.marvin24@gmx.de>
References: <cover.1320088857.git.marvin24@gmx.de>
	<855f09f77c03a9f081818a03effdbd3bf7a30c91.1320088857.git.marvin24@gmx.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173EDAB86E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Monday, October 31, 2011 1:59 PM:
> This adds a dts file for paz00. As a side effect, this also enables
> the embedded controller which controls the keyboard, touchpad, power,
> leds, and some other functions.
...
> +	serial at 70006000 {
> +		clock-frequency = <216000000>;
> +	};
> +
> +	serial at 70006040 {
> +		status = "disable";
> +	};
> +
> +	serial at 70006200 {
> +		status = "disable";
> +	};
> +
> +	serial at 70006300 {
> +		clock-frequency = <216000000>;
> +	};

Don't you also want to disable serial at 70006400, or set a clock rate for
it?

-- 
nvpublic
