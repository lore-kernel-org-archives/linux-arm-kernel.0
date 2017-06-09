From: jagan@openedev.com (Jagan Teki)
Date: Fri, 9 Jun 2017 20:56:26 +0530
Subject: [linux-sunxi] Re: [PATCH v2] arm64: allwinner: a64: Add initial
 NanoPi A64 support
In-Reply-To: <20170609145141.aknbsis25vmy3rj6@flea.home>
References: <1497012052-14027-1-git-send-email-jteki@openedev.com>
 <1497012052-14027-2-git-send-email-jteki@openedev.com>
 <20170609145141.aknbsis25vmy3rj6@flea.home>
Message-ID: <3049841d-36f0-a761-fbed-57971462697c@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 June 2017 08:21 PM, Maxime Ripard wrote:
> Hi Jagan,
> 
> On Fri, Jun 09, 2017 at 12:40:52PM +0000, Jagan Teki wrote:
>> +&i2c1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c1_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c1_pins {
>> +	bias-pull-up;
>> +};
> 
> What is connected on that bus?

i2c1 connected with gpio/i2s

> 
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>> +	status = "okay";
>> +};
> 
> And on that UART?

uart1 for SDIO (Wifi connector, with RTS/CTS), this along with mmc1

Jagan.
