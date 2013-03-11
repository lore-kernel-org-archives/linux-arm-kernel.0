From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 11 Mar 2013 10:57:10 +0100
Subject: [PATCH 3/3] can: Kconfig: CAN_AT91 depends on ARCH_AT91
In-Reply-To: <20130311092419.GB2572@ludovic.desroches@atmel.com>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-4-git-send-email-ludovic.desroches@atmel.com>
 <513A2396.4080508@pengutronix.de>
 <20130311092419.GB2572@ludovic.desroches@atmel.com>
Message-ID: <513DAA76.6040803@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 10:24 AM, Ludovic Desroches wrote:
> On Fri, Mar 08, 2013 at 06:44:54PM +0100, Marc Kleine-Budde wrote:
>> On 03/08/2013 06:30 PM, ludovic.desroches at atmel.com wrote:
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> SAMA5D3 devices also embed CAN feature. Moreover if we want to produce a single
>>> kernel image (at least for Atmel devices) it is not useful to be too
>>> restrictive.
>>
>> If it compiles on other ARMs aswell we can make it depend on ARCH_ARM.
>> 
> I was thinking about it but I am wondering if it makes sense. Should we have a
> non atmel device with atmel can?

I don't know if atmels sells the IP core separately, but ARM Linux is
going towards a multi ARCH kernel anyways. So the can core should
compile on non atmel and/or multi arch kernels.

> I have no position about this point, if you think it's better to make
> it depending onto ARCH_ARM, I'll change it if there is no compilation
> issue.

Please make it so.

regards,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130311/1be12da8/attachment.sig>
