From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Wed, 7 Nov 2012 01:38:44 +0100
Subject: [PATCHv3 1/6] arch: Change defconfigs to point to g_mass_storage.
In-Reply-To: <007d0b4e8872b877076918bd3268832e9ea9d667.1352237765.git.mina86@mina86.com>
References: <cover.1352237765.git.mina86@mina86.com>
 <007d0b4e8872b877076918bd3268832e9ea9d667.1352237765.git.mina86@mina86.com>
Message-ID: <20121107003844.GA8837@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Tue 06 Nov 2012 22:52:35 +0100 or thereabout, Michal Nazarewicz wrote:
> From: Michal Nazarewicz <mina86@mina86.com>
> 
> The File-backed Storage Gadget (g_file_storage) is being removed, since
> it has been replaced by Mass Storage Gadget (g_mass_storage).  This commit
> changes defconfigs point to the new gadget.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>  (fort AT91)
> Acked-by: Tony Lindgren <tony@atomide.com>  (for omap1)
> ---
>  arch/arm/configs/afeb9260_defconfig                |    2 +-
>  arch/arm/configs/at91sam9260_defconfig             |    2 +-
>  arch/arm/configs/at91sam9261_defconfig             |    2 +-
>  arch/arm/configs/at91sam9263_defconfig             |    2 +-
>  arch/arm/configs/at91sam9g20_defconfig             |    2 +-
>  arch/arm/configs/corgi_defconfig                   |    2 +-
>  arch/arm/configs/davinci_all_defconfig             |    2 +-
>  arch/arm/configs/h7202_defconfig                   |    3 +--
>  arch/arm/configs/magician_defconfig                |    2 +-
>  arch/arm/configs/mini2440_defconfig                |    2 +-
>  arch/arm/configs/omap1_defconfig                   |    3 +--
>  arch/arm/configs/prima2_defconfig                  |    1 -
>  arch/arm/configs/spitz_defconfig                   |    2 +-
>  arch/arm/configs/stamp9g20_defconfig               |    2 +-
>  arch/arm/configs/viper_defconfig                   |    2 +-
>  arch/arm/configs/zeus_defconfig                    |    2 +-
>  arch/avr32/configs/atngw100_defconfig              |    2 +-
>  arch/avr32/configs/atngw100_evklcd100_defconfig    |    2 +-
>  arch/avr32/configs/atngw100_evklcd101_defconfig    |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig         |    2 +-
>  arch/avr32/configs/atngw100mkii_defconfig          |    2 +-
>  .../avr32/configs/atngw100mkii_evklcd100_defconfig |    2 +-
>  .../avr32/configs/atngw100mkii_evklcd101_defconfig |    2 +-
>  arch/avr32/configs/atstk1002_defconfig             |    2 +-
>  arch/avr32/configs/atstk1003_defconfig             |    2 +-
>  arch/avr32/configs/atstk1004_defconfig             |    2 +-
>  arch/avr32/configs/atstk1006_defconfig             |    2 +-
>  arch/avr32/configs/favr-32_defconfig               |    2 +-
>  arch/avr32/configs/hammerhead_defconfig            |    2 +-

For all the AVR32 related changes +1 (-:

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

IMHO this patch is trivial and needed since you change all the users of a
certain symbol. Thanks for doing the maintenance.

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
