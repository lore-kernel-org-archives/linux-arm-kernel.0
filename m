From: Michal.Vokac@ysoft.com (=?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?=)
Date: Wed, 28 Nov 2018 08:23:17 +0000
Subject: [PATCH] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
In-Reply-To: <20181128023859.GB20643@dragon>
References: <1541086962-52626-1-git-send-email-michal.vokac@ysoft.com>
 <20181128023859.GB20643@dragon>
Message-ID: <60126654-7893-64a6-6269-1129d4fff455@ysoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.11.2018 03:39, Shawn Guo wrote:
> On Thu, Nov 01, 2018 at 03:43:26PM +0000, Vok?? Michal wrote:
> ...
>> +&usdhc3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc3>;
>> +	bus-width = <4>;
>> +	cd-gpios = <&gpio7 8 GPIO_ACTIVE_LOW>;
>> +	wp-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
>> +	no-1-8-v;
>> +	keep-power-in-suspend;
>> +	enable-sdio-wakeup;
> 
> This property is deprecated.  Please use "wakeup-source" instead.

OK, I will fix that. Thanks for the heads up.

Michal

>> +	vmmc-supply = <&sw2_reg>;
>> +	status = "disabled";
>> +};
