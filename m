From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 10 Feb 2017 15:45:15 +0100
Subject: [PATCH v4 0/9] ARM: dts: support I2SE Duckbill devices
In-Reply-To: <1486626169-20022-1-git-send-email-michael.heimpold@i2se.com>
References: <1486626169-20022-1-git-send-email-michael.heimpold@i2se.com>
Message-ID: <a6386810-1e99-130a-5fdf-02cce13d0fc4@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.02.2017 um 08:42 schrieb Michael Heimpold:
> This series updates/adds Device Tree support for I2SE's Duckbill
> device family.
>
> The Duckbill devices are small, pen-drive sized boards based on
> NXP's i.MX28 SoC. While the initial variants (Duckbill series) were
> equipped with a micro SD card slot only, the latest generation
> (Duckbill 2 series) have an additional internal eMMC onboard.
>
> Both device generations consists of four "family members":
>
> - Duckbill/Duckbill 2: generic board, intended to be used as
>   baseboard for custom designs and/or as development board
>
> - Duckbill EnOcean/Duckbill 2 EnOcean: come with an EnOcean
>   daugther board equipped with the popular TCM310 module
>
> - Duckbill 485/Duckbill 2 485: as the name implies, these
>   devices are intended to be used as Ethernet - RS485 converters
>
> - Duckbill SPI/Duckbill 2 SPI: not sold separately, but used
>   in I2SE's development kits for Green PHY HomePlug Powerline
>   communication
>
> Because the Duckbill series is EOL, this patch series only adds
> support for the latest Duckbill 2 series devices. However,
> support for the generic Duckbill board was already mainline,
> so update it to match vendor tree DT.

I'm fine with the complete series.

Regards
