From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 25 Jan 2016 14:35:01 +0100
Subject: [PATCH 1/3] ARM: dts: sama5d4: cleanup - add blank lines between
 pinctrl nodes
In-Reply-To: <20160125111841.GB4027@piout.net>
References: <1453293337-16078-1-git-send-email-LW@KARO-electronics.de>
 <1453293337-16078-2-git-send-email-LW@KARO-electronics.de>
 <20160125111841.GB4027@piout.net>
Message-ID: <56A62485.3060807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/01/2016 12:18, Alexandre Belloni a ?crit :
> Hi,
> 
> On 20/01/2016 at 13:35:35 +0100, Lothar Wa?mann wrote :
> 
> A commit message is mandatory even when small ;)
> 
>> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> 
> I'm not sure the added blank lines add any clarity to the fille but I
> won't object. Maybe Nicolas as an opinion.

Well, I don't think it brings more coherency to the .dtsi. For example
some trigger definitions nodes don't have the blank line neither. Other
products .dtsi are the same.

As it may cause merging issues without real gain, I'm sorry but it's a
NACK for me.

Bye,

>> ---
>>  arch/arm/boot/dts/sama5d4.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
>> index b8032bc..6c0dc89 100644
>> --- a/arch/arm/boot/dts/sama5d4.dtsi
>> +++ b/arch/arm/boot/dts/sama5d4.dtsi
>> @@ -1428,22 +1428,27 @@
>>  						atmel,pins =
>>  							<AT91_PIOE 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* conflicts with USBA_VBUS */
>>  					};
>> +
>>  					pinctrl_adc0_ad0: adc0_ad0 {
>>  						atmel,pins =
>>  							<AT91_PIOC 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
>>  					};
>> +
>>  					pinctrl_adc0_ad1: adc0_ad1 {
>>  						atmel,pins =
>>  							<AT91_PIOC 28 AT91_PERIPH_A AT91_PINCTRL_NONE>;
>>  					};
>> +
>>  					pinctrl_adc0_ad2: adc0_ad2 {
>>  						atmel,pins =
>>  							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_NONE>;
>>  					};
>> +
>>  					pinctrl_adc0_ad3: adc0_ad3 {
>>  						atmel,pins =
>>  							<AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE>;
>>  					};
>> +
>>  					pinctrl_adc0_ad4: adc0_ad4 {
>>  						atmel,pins =
>>  							<AT91_PIOC 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;
>> @@ -1497,11 +1502,13 @@
>>  							 AT91_PIOB  3 AT91_PERIPH_C AT91_PINCTRL_NONE	/* ISI_VSYNC */
>>  							 AT91_PIOB  4 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* ISI_HSYNC */
>>  					};
>> +
>>  					pinctrl_isi_data_8_9: isi-0-data-8-9 {
>>  						atmel,pins =
>>  							<AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_NONE	/* ISI_D8, conflicts with SPI0_MISO, PWMH2 */
>>  							 AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* ISI_D9, conflicts with SPI0_MOSI, PWML2 */
>>  					};
>> +
>>  					pinctrl_isi_data_10_11: isi-0-data-10-11 {
>>  						atmel,pins =
>>  							<AT91_PIOC 2 AT91_PERIPH_C AT91_PINCTRL_NONE	/* ISI_D10, conflicts with SPI0_SPCK, PWMH3 */
>> @@ -1517,9 +1524,11 @@
>>  							 AT91_PIOA 29 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDDEN */
>>  							 AT91_PIOA 28 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDPCK */
>>  					};
>> +
>>  					pinctrl_lcd_pwm: lcd-pwm-0 {
>>  						atmel,pins = <AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDPWM */
>>  					};
>> +
>>  					pinctrl_lcd_rgb444: lcd-rgb-0 {
>>  						atmel,pins =
>>  							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD0 pin */
>> @@ -1535,6 +1544,7 @@
>>  							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD10 pin */
>>  							 AT91_PIOA 11 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDD11 pin */
>>  					};
>> +
>>  					pinctrl_lcd_rgb565: lcd-rgb-1 {
>>  						atmel,pins =
>>  							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD0 pin */
>> @@ -1554,6 +1564,7 @@
>>  							 AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD14 pin */
>>  							 AT91_PIOA 15 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDD15 pin */
>>  					};
>> +
>>  					pinctrl_lcd_rgb666: lcd-rgb-2 {
>>  						atmel,pins =
>>  							<AT91_PIOA 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD2 pin */
>> @@ -1575,6 +1586,7 @@
>>  							 AT91_PIOA 22 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD22 pin */
>>  							 AT91_PIOA 23 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDD23 pin */
>>  					};
>> +
>>  					pinctrl_lcd_rgb777: lcd-rgb-3 {
>>  						atmel,pins =
>>  							 /* LCDDAT0 conflicts with TMS */
>> @@ -1602,6 +1614,7 @@
>>  							 AT91_PIOA 22 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD22 pin */
>>  							 AT91_PIOA 23 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDD23 pin */
>>  					};
>> +
>>  					pinctrl_lcd_rgb888: lcd-rgb-4 {
>>  						atmel,pins =
>>  							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD0 pin */
>> -- 
>> 2.1.4
>>
> 


-- 
Nicolas Ferre
