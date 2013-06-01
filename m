From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sat, 01 Jun 2013 10:32:05 +0200
Subject: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
In-Reply-To: <1370043630.3928.166.camel@pasglop>
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
 <20130517090949.GI8607@S2101-09.ap.freescale.net>
 <519A4A00.8000109@pengutronix.de> <1370043630.3928.166.camel@pasglop>
Message-ID: <51A9B185.9030107@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2013 01:40 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-20 at 18:06 +0200, Marc Kleine-Budde wrote:
>> On 05/17/2013 11:09 AM, Shawn Guo wrote:
>>> On Fri, May 17, 2013 at 10:59:17AM +0200, Marc Kleine-Budde wrote:
>>>> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{arm,powerpc}
>>>> and allowing compilation unconditionally on all arm and powerpc platforms.
>>>>
>>>> This brings a bigger compile time coverage and removes the following dependency
>>>> warning found by Arnd Bergmann:
>>>>
>>>>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFORM_FLEXCAN &&
>>>>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
>>>>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
>>>>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>>
>>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> Thanks.
>>
>> An Acked-by by the powerpc people would be fine. However, if nobody
>> doesn't object, I'm sending this patch via linux-can and net-next upstream.
> 
> Sorry, missed it, if it's still out there, add my
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130601/ed9979e4/attachment.sig>
