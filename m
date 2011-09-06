From: sbabic@denx.de (Stefano Babic)
Date: Tue, 06 Sep 2011 11:14:36 +0200
Subject: [PATCH] ARM: mxs: Add initial support for DENX MX28
In-Reply-To: <20110906084627.GB2610@pengutronix.de>
References: <1314604250-29511-1-git-send-email-sbabic@denx.de>	<20110906083926.GE28816@pengutronix.de>
	<20110906084627.GB2610@pengutronix.de>
Message-ID: <4E65E47C.3080505@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2011 10:46 AM, Wolfram Sang wrote:
>>>  
>>> +config MODULE_M28
>>> +	bool
>>> +	select SOC_IMX28
>>> +	select LEDS_GPIO_REGISTER
>>> +	select MXS_HAVE_AMBA_DUART
>>> +	select MXS_HAVE_PLATFORM_AUART
>>> +	select MXS_HAVE_PLATFORM_FEC
>>> +	select MXS_HAVE_PLATFORM_FLEXCAN
>>> +	select MXS_HAVE_PLATFORM_MXS_MMC
>>> +	select MXS_HAVE_PLATFORM_MXSFB
>>> +	select MXS_OCOTP
>>> +
>>>  config MACH_TX28
>>>  	bool "Ka-Ro TX28 module"
>>>  	select MODULE_TX28
>>>  
>>> +config MACH_M28EVK
>>> +	bool "Support DENX M28EVK Platform"
>>> +	select MODULE_M28
>>> +
> 
> Does it build?

Yes, but only because my config contains MXS_HAVE_PLATFORM_MXS_I2C...

> I'd think MXS_HAVE_PLATFORM_MXS_I2C is missing?

Thanks for catching it !

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================
