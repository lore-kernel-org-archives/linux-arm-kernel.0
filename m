From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Nov 2012 08:38:29 +0000
Subject: linux-next: manual merge of the arm-soc tree with the battery tree
In-Reply-To: <20121127155223.849e73a08fc1b382d4622ff8@canb.auug.org.au>
References: <20121127155223.849e73a08fc1b382d4622ff8@canb.auug.org.au>
Message-ID: <201211270838.29360.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 November 2012, Stephen Rothwell wrote:

>   
>  -config AB8500_BATTERY_THERM_ON_BATCTRL
>  -	bool "Thermistor connected on BATCTRL ADC"
>  -	depends on AB8500_BM
>  -	help
>  -	  Say Y to enable battery temperature measurements using
>  -	  thermistor connected on BATCTRL ADC.
>  -
> + source "drivers/power/reset/Kconfig"
> + 
>   endif # POWER_SUPPLY
>   
>   source "drivers/power/avs/Kconfig"
> 


Looks good, thanks!

	Arnd
