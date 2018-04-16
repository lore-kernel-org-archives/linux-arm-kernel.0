From: marex@denx.de (Marek Vasut)
Date: Mon, 16 Apr 2018 16:49:10 +0200
Subject: [PATCH V3] ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM
 and PDK2
In-Reply-To: <20180416144753.GK25429@dragon>
References: <20180318173403.31460-1-marex@denx.de>
 <20180416144753.GK25429@dragon>
Message-ID: <7e95e932-f217-b9f2-1e4d-5144af5c79e1@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2018 04:47 PM, Shawn Guo wrote:
> On Sun, Mar 18, 2018 at 06:34:03PM +0100, Marek Vasut wrote:
>> +&i2c2 {
>> +	sgtl5000: codec at a {
>> +		compatible = "fsl,sgtl5000";
>> +		reg = <0x0a>;
> 
> Since commit c4e50b1d87fb ("ASoC: sgtl5000: Pass the required
> '#sound-dai-cells'"), #sound-dai-cells is required for sgtl5000 device.
> I added the following line here, and applied the patch.
> 
> 	#sound-dai-cells = <0>;

Thanks

-- 
Best regards,
Marek Vasut
