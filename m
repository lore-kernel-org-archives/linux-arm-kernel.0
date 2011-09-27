From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Sep 2011 20:19:00 +0530
Subject: [PATCH 5/9] regulator: helper routine to extract
	fixed_voltage_config
In-Reply-To: <20110927121622.GD4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-6-git-send-email-rnayak@ti.com>
	<20110927121622.GD4289@opensource.wolfsonmicro.com>
Message-ID: <4E81E25C.5080500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 September 2011 05:46 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:48PM +0530, Rajendra Nayak wrote:
>> The helper routine of_get_fixed_voltage_config() extracts
>> fixed_voltage_config structure contents from device tree.
>>
>> Also add documenation for additional bindings for fixed
>> regulators that can be passed through dt.
>
> Why not just add device tree support into the driver directly?

Ok, will do.

>
>> +Optional properties:
>> +- regulator-fixed-supply: Name of the regulator supply
>
> This is going to be confusing with respect to the generic regulator
> supply property.

Yes, I guess. Any suggestions on how to make it less
confusing? :-)

>
>> +- regulator-fixed-enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
>
> Word wrap for legibility please.

Ok.
