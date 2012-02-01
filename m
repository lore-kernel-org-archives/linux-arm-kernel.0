From: sbabic@denx.de (Stefano Babic)
Date: Wed, 01 Feb 2012 11:51:16 +0100
Subject: [PATCH V2] mt_ventoux: support for TeeJet Mt.Ventoux board
In-Reply-To: <1325027377-13484-1-git-send-email-yanok@emcraft.com>
References: <1324940912-18164-3-git-send-email-yanok@emcraft.com>
 <1325027377-13484-1-git-send-email-yanok@emcraft.com>
Message-ID: <4F291924.50702@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/12/2011 00:09, Ilya Yanok wrote:
> This patch adds support for TeeJet Mt.Ventoux board based on TAM3517
> SOM. Supported devices:
>  - Serial
>  - Ethernet
>  - NAND
>  - USB host
>  - LCD
>  - Touchscreen
>  - CAN controller
>  - ADC128S converter
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> 
> Changes from V1:
> 
>  - Fixed indentation (use tabs not spaces)
>  - Fixed over 80 characters lines
>  - Added #if defined(CONFIG_SENSORS_ADCXX_MODULE) to allow adcxx to be a
>    module.
>  - Fixes for compilation with CONFIG_TOUCHSCREEN_ADS7846!=y
>   - Added defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
>   - Moved call to omap_ads7846_init to separate small function
>   - Register fixed regulator used for touchscreen only if the driver is
>     enabled
>  - Changed board name (MT_VENTOUX -> Mt.Ventoux)

Hi Tony,

can I ask you about the status of these patches ? I have not seen open
comments, do you think they can be merged in your tree ?

Thanks,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================
