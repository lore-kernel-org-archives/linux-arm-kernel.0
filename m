From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 4 Nov 2014 13:05:47 -0200
Subject: [PATCH v2] ARM: imx: Fix the removal of CONFIG_SPI option
In-Reply-To: <20141104110713.GK10821@tiger>
References: <1415096927-4097-1-git-send-email-festevam@gmail.com>
 <20141104110713.GK10821@tiger>
Message-ID: <CAOMZO5Bb+1UisCUe4Rz-6_7u6JpY3gj5M5Aui_odG9JS4dq8qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Tue, Nov 4, 2014 at 9:07 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Nov 04, 2014 at 08:28:47AM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Since 64546e9fe3a5b8c ("ARM: imx_v6_v7_defconfig updates") and commit
>> 0650f855d2e4b0b9 ("ARM: imx_v4_v5_defconfig: Select CONFIG_IMX_WEIM") CONFIG_SPI
>> selection was dropped by savedefconfig for imx_v4_v5_defconfig and
>> imx_v6_v7_defconfig.
>>
>> In order to keep the same behaviour as previous kernel versions and avoid
>> regressions, let's add CONFIG_SPI option back.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Applied, thanks.

I have just sent a v3, with an explanation as to why savedefconfig
dropped CONFIG_SPI=y.

Thanks to Uwe for his analysis!
