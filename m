From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 07 May 2012 10:29:42 +0200
Subject: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
In-Reply-To: <CAAQ0ZWSzrfFm+=m+s8S3FDG5k_OrULN58VUVCBE=fwU0r=ZD+g@mail.gmail.com>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
 <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
 <4FA78298.4080401@pengutronix.de>
 <CAAQ0ZWSzrfFm+=m+s8S3FDG5k_OrULN58VUVCBE=fwU0r=ZD+g@mail.gmail.com>
Message-ID: <4FA787F6.4060405@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2012 10:17 AM, Shawn Guo wrote:
> On 7 May 2012 16:06, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> It doesn't compile yet against net-next/master, which is based on v3.4-rc4:
>>
>> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c: In
>> function 'flexcan_probe':
>> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c:937:
>> error: implicit declaration of function 'devm_pinctrl_get_select_default'
>> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c:937:
>> warning: assignment makes pointer from integer without a cast
>>
>> Which tree does this series depend on? If this should go over the
>> linux-can tree, I have to ask David first to merge this.
>>
> Thanks for the response, Marc.  The patch depends on pinctrl tree and
> a couple of other patches that will go through arm-soc tree, so I
> would like to ask for your ack to have the patch go over arm-soc tree.

Fine with me. David, is this okay? Shawn, better wait for David's okay.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/e673a848/attachment.sig>
