From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 1 Nov 2016 10:44:36 +0000
Subject: [PATCH 2/3] ARM: imx: mach-imx6ul: add imx6ull support
In-Reply-To: <CAOMZO5AsF8s9Ff2NHQ+j2_xSBNEzGY6bGLK-kgvx-aST+K2PNQ@mail.gmail.com>
References: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
 <1477969343-19887-3-git-send-email-peter.chen@nxp.com>
 <CAOMZO5AsF8s9Ff2NHQ+j2_xSBNEzGY6bGLK-kgvx-aST+K2PNQ@mail.gmail.com>
Message-ID: <HE1PR04MB1450456D09E01C3F308D25AB8BA10@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>
>On Tue, Nov 1, 2016 at 1:02 AM, Peter Chen <peter.chen@nxp.com> wrote:
>> imx6ull is derived SoC from imx6ul.
>>
>> Signed-off-by: Peter Chen <peter.chen@nxp.com>
>> ---
>>  arch/arm/mach-imx/mach-imx6ul.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-imx/mach-imx6ul.c
>> b/arch/arm/mach-imx/mach-imx6ul.c index 58a2b88..0b24630 100644
>> --- a/arch/arm/mach-imx/mach-imx6ul.c
>> +++ b/arch/arm/mach-imx/mach-imx6ul.c
>> @@ -89,10 +89,11 @@ static void __init imx6ul_init_late(void)
>>
>>  static const char * const imx6ul_dt_compat[] __initconst = {
>>         "fsl,imx6ul",
>> +       "fsl,imx6ull",
>>         NULL,
>>  };
>>
>> -DT_MACHINE_START(IMX6UL, "Freescale i.MX6 Ultralite (Device Tree)")
>> +DT_MACHINE_START(IMX6UL, "Freescale i.MX6 UltraLite (Device Tree)")
>
>Is this change really needed?

This change does not be related with imx6ull support, but also a needed change since
the formal name is capital letter "L", if you are concerned with that, I can delete this
change.

Peter
