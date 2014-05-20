From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 20 May 2014 15:55:32 +0200
Subject: [PATCH v2 2/3] ARM: dts: overo: Add support for 4.3'' LCD output
In-Reply-To: <537B4D6B.5070106@ti.com>
References: <1400589069-21572-1-git-send-email-florian.vaussard@epfl.ch>
 <1400589069-21572-3-git-send-email-florian.vaussard@epfl.ch>
 <537B4D6B.5070106@ti.com>
Message-ID: <537B5ED4.3040805@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/20/2014 02:41 PM, Tomi Valkeinen wrote:
> On 20/05/14 15:31, Florian Vaussard wrote:
> 
>> +	lcd0: display at 0 { +		compatible = "samsung,lte430wq-f0c",
>> "panel-dpi"; +		label = "lcd"; + +		gpios = <&gpio5 16
>> GPIO_ACTIVE_HIGH		/* gpio_144: enable */ +			 &gpio5 17
>> GPIO_ACTIVE_HIGH>;		/* gpio_145: brightness */
> 
> The panel-dpi only takes one gpio, the enable. The backlight should
> be handled with gpio-backlight driver.
> 
> The same applies for the Alto35 patch.
> 

Indeed. I will send a v3.

Regards,
Florian
