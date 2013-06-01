From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sat, 01 Jun 2013 11:56:17 +0200
Subject: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
In-Reply-To: <4297748.x0TtCUl2dJ@wuerfel>
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
 <4297748.x0TtCUl2dJ@wuerfel>
Message-ID: <51A9C541.9080300@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2013 10:59 AM, Arnd Bergmann wrote:
> On Friday 17 May 2013 10:59:17 Marc Kleine-Budde wrote:
>> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{arm,powerpc}
>> and allowing compilation unconditionally on all arm and powerpc platforms.
>>
>> This brings a bigger compile time coverage and removes the following dependency
>> warning found by Arnd Bergmann:
>>
>>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFORM_FLEXCAN &&
>>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
>>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: U Bhaskar-B22300 <B22300@freescale.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linuxppc-dev at lists.ozlabs.org
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for addressing this!

I'll include this patch in my next pull request to David Miller.

Tnx,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130601/4b7f9be7/attachment.sig>
