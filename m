From: marex@denx.de (Marek Vasut)
Date: Mon, 06 Jun 2016 15:12:08 +0200
Subject: [PATCH V2 3/4] ARM: mxs: dts: Add Creative X-Fi3 support
In-Reply-To: <20160606084521.GA25155@tiger>
References: <1462740621-7557-1-git-send-email-marex@denx.de>
 <1462740621-7557-3-git-send-email-marex@denx.de>
 <20160606084521.GA25155@tiger>
Message-ID: <575576A8.2010208@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 10:45 AM, Shawn Guo wrote:
> On Sun, May 08, 2016 at 10:50:20PM +0200, Marek Vasut wrote:
>> +	regulators {
>> +		compatible = "simple-bus";
>> +
>> +		reg_vddio_sd0: vddio-sd0 {
>> +			compatible = "regulator-fixed";
>> +			regulator-name = "vddio-sd0";
>> +			regulator-min-microvolt = <3300000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			gpio = <&gpio0 7 0>;
>> +		};
>> +	};
> 
> For new dts, we suggest put fixed regulator node directly under root in
> the following naming scheme:
> 
> 	reg_xxx: regulator-xxx {
> 		...
> 	};
> 
> Also, the order of subject prefix is like ARM: dts: mxs: ...

I see, can you do this trivial fix while applying ?

Thanks

-- 
Best regards,
Marek Vasut
