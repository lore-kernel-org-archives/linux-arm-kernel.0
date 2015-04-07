From: g.portay@overkiz.com (g.portay at overkiz.com)
Date: Tue, 07 Apr 2015 21:40:56 +0200
Subject: [PATCH 1/2] ARM: at91/dt: sam9x5: add pinctrl for pwm0
In-Reply-To: <20150407192231.GW20669@piout.net>
References: <1428415884-30662-1-git-send-email-g.portay@overkiz.com>
 <1428415884-30662-2-git-send-email-g.portay@overkiz.com>
 <20150407192231.GW20669@piout.net>
Message-ID: <8817d74520bc99a9ee01fe303dc335cd@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-07 21:22, Alexandre Belloni wrote:
> Hi Ga?l,
> 
> On 07/04/2015 at 16:11:23 +0200, Ga?l PORTAY wrote :
>> Defines the pinctrl configurations for PWM0.
>> 
>> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
>> ---
>>  arch/arm/boot/dts/at91sam9x5.dtsi | 46 
>> +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi 
>> b/arch/arm/boot/dts/at91sam9x5.dtsi
>> index d221179..08ed53d 100644
>> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
>> @@ -463,6 +463,52 @@
>>  					};
>>  				};
>> 
>> +				pwm0 {
>> +					pinctrl_pwm0_pwm0_0: pwm0_pwm0-0 {
>> +						atmel,pins =
>> +							<AT91_PIOB 11 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB11 periph 
>> B */
>                                            please drop those useless
> comments --^
> 
> Else, I'm fine with that patch.

I do think so... I added them for consistency only... I will drop them 
in v2.

Do you want I drop all those kind of comments (of the whole file) as 
well ?

Thanks for your review.
