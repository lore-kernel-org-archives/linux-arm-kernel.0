From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 01 Aug 2012 11:46:45 +0200
Subject: [PATCH 2/4] ARM: dts: mxs: Add alternative I2C muxing options
 for imx28
In-Reply-To: <CAOMZO5AaLB5m7TYPC03wTSFTDUTFrtV4Xr6gHrvKuGnpyUsf8Q@mail.gmail.com>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-3-git-send-email-maxime.ripard@free-electrons.com>
 <CAOMZO5AaLB5m7TYPC03wTSFTDUTFrtV4Xr6gHrvKuGnpyUsf8Q@mail.gmail.com>
Message-ID: <5018FB05.3020902@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 31/07/2012 14:02, Fabio Estevam a ?crit :
> On Tue, Jul 31, 2012 at 7:29 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
>> +                               i2c0_pins_b: i2c0 at 1 {
>> +                                       reg = <1>;
>> +                                       fsl,pinmux-ids = <0x3001 0x3011>;
> 
> Can you please also list the name of the pin as comment (just like you
> did for pwm4)?
> 
> This would allow us to quickly identify the muxing option without the
> need of looking at the mxs pinctrl doc.

You're right, this will be in the next version.

Thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
