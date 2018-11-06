From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 6 Nov 2018 10:18:01 +0100
Subject: [PATCH 2/2] arm64: dts: r8a77990: ebisu: Enable SDHI interfaces
In-Reply-To: <20181106083450.GB1054@kunai>
References: <20181105214117.11734-1-marek.vasut+renesas@gmail.com>
 <20181105214117.11734-2-marek.vasut+renesas@gmail.com>
 <20181106083450.GB1054@kunai>
Message-ID: <3e933acf-33d1-ca27-e463-57345c79396a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2018 09:34 AM, Wolfram Sang wrote:
> 
>> +	sdhi3_pins: sd3 {
>> +		groups = "sdhi3_data8", "sdhi3_ctrl";
>> +		function = "sdhi3";
>> +		power-source = <1800>;
>> +	};
>> +
>> +	sdhi3_pins_uhs: sd3_uhs {
>> +		groups = "sdhi3_data8", "sdhi3_ctrl";
>> +		function = "sdhi3";
>> +		power-source = <1800>;
>> +	};
> 
> Shouldn't we have only one pinctrl config here, like you did recently
> for the other Gen3 SoCs?

We should, thanks for pointing it out, fixed in V2.

-- 
Best regards,
Marek Vasut
