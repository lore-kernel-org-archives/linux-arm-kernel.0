From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Sep 2013 10:04:02 -0300
Subject: [PATCH 03/22] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <20130716074650.GD30067@S2101-09.ap.freescale.net>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-4-git-send-email-denis@eukrea.com>
 <20130716074650.GD30067@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5AZO=BMK9rU-OKjUiQfos=Vw4Hx6aSfPho5yEcD5ercTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Tue, Jul 16, 2013 at 4:46 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Jul 15, 2013 at 04:56:48PM +0200, Denis Carikli wrote:
>> This is mostly cut and paste from the imx35 pinctrl driver.
>> The data was generated using sed and awk on
>>   arch/arm/plat-mxc/include/mach/iomux-mx25.h.
>>
>> Signed-off-by: Denis Carikli <denis@eukrea.com>
>> ---
>>  .../bindings/pinctrl/fsl,imx25-pinctrl.txt         |   33 ++
>>  arch/arm/boot/dts/imx25-pinfunc.h                  |  513 ++++++++++++++++++++
>>  arch/arm/boot/dts/imx25.dtsi                       |    1 +
>>  arch/arm/mach-imx/Kconfig                          |    2 +
>>  drivers/pinctrl/Kconfig                            |    8 +
>>  drivers/pinctrl/Makefile                           |    1 +
>>  drivers/pinctrl/pinctrl-imx25.c                    |  351 ++++++++++++++
>
> Either we split it into driver part and mach part, or I need an ACK from
> pinctrl maintainer to take the patch via IMX tree.

Do you plan to re-submit this patch?

Regards,

Fabio Estevam
