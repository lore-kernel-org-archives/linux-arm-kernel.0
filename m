From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 4 Jun 2013 03:37:50 +0000
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <CAOMZO5Bo58Qa0Rmz+oKt0ZOUjYDDskBsPykCVc79j4mybcG8rA@mail.gmail.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
 <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
 <B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net>
 <CAOMZO5DzVhh4REj5S=cVVVrGzxmTxY9s_h_6ZQ-G8wOxi+KG=A@mail.gmail.com>
 <CAOMZO5Bo58Qa0Rmz+oKt0ZOUjYDDskBsPykCVc79j4mybcG8rA@mail.gmail.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CF028@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Fabio Estevam [mailto:festevam at gmail.com]
>Sent: Tuesday, June 04, 2013 11:09 AM
>To: Lu Jingchang-B35083
>Cc: linux-serial at vger.kernel.org; gregkh at linuxfoundation.org;
>s.hauer at pengutronix.de; shawn.guo at linaro.org; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH v6] tty: serial: add Freescale lpuart driver support
>
>On Tue, Jun 4, 2013 at 12:08 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Tue, Jun 4, 2013 at 12:02 AM, Lu Jingchang-B35083
>> <B35083@freescale.com> wrote:
>>
>>> [Lu Jingchang-B35083]
>>>   SERIAL_FSL_LPUART_CONSOLE depends on SERIAL_FSL_LPUART=y in the patch
>as below, when SERIAL_FSL_LPUART is configured as module, it can't be
>configured as console. Thanks!
>>
>> Why to prevent using the console of the driver is built as module?
>
>I meant "if the driver is built as module"
[Lu Jingchang-B35083] 
In serial driver imx.c, when CONFIG_SERIAL_IMX_CONSOLE=m, does the code between #ifdef CONFIG_SERIAL_IMX_CONSOLE ... #else be compiled?
Thanks! 
