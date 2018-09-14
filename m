From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 13 Sep 2018 23:48:30 -0500
Subject: [PATCH] ARM: dts: socfpga: Fix I2C bus unit-address error
In-Reply-To: <20180913181245.25484-13-robh@kernel.org>
References: <20180913181245.25484-13-robh@kernel.org>
Message-ID: <086796ff-989e-4cca-f85e-0a2a9878c41e@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/13/2018 01:12 PM, Rob Herring wrote:
> dtc has new checks for I2C buses. Fix the warnings in unit-addresses.
> 
> arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dtb: Warning (i2c_bus_reg): /soc/i2c at ffc04000/adxl345 at 0: I2C bus unit address format error, expected "53"
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.
> 

Thanks for the fix! Applied!

Dinh
