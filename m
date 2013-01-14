From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 14 Jan 2013 17:01:52 +0800
Subject: [PATCH 0/3] at91: PMECC: enable PMECC in dt for at91sam9x5ek,
 at91sam9n12ek
In-Reply-To: <1355912840-29501-1-git-send-email-josh.wu@atmel.com>
References: <1355912840-29501-1-git-send-email-josh.wu@atmel.com>
Message-ID: <50F3C980.7070507@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Ping? Any feedback for these patches?

On 12/19/2012 6:27 PM, Josh Wu wrote:
> Those patches will enable PMECC in dt parameters for at91sam9x5ek, at91sam9n12ek.
>
> Josh Wu (3):
>    MTD: at91: atmel_nand: for PMECC, add code to choose the ecc bits and
>      sector size according to the ONFI parameter ECC requirement.
>    at91: 9x5: add DT parameters to enable PMECC
>    at91: at91sam9n12: add DT parameters to enable PMECC
>
>   arch/arm/boot/dts/at91sam9n12.dtsi  |    1 +
>   arch/arm/boot/dts/at91sam9n12ek.dts |    5 +-
>   arch/arm/boot/dts/at91sam9x5.dtsi   |    4 ++
>   arch/arm/boot/dts/at91sam9x5cm.dtsi |    5 +-
>   drivers/mtd/nand/atmel_nand.c       |   89 +++++++++++++++++++++++++++++++++++
>   5 files changed, 102 insertions(+), 2 deletions(-)
>

Best Regards,
Josh Wu
