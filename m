From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 22 Jul 2010 08:34:20 +0200
Subject: [PATCH 2/5] mx25: Add flexcan devices
In-Reply-To: <911441.33834.qm@web51008.mail.re2.yahoo.com>
References: <911441.33834.qm@web51008.mail.re2.yahoo.com>
Message-ID: <4C47E66C.3010305@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam wrote:
> Marc,
> 
> --- On Wed, 7/21/10, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> ...
>>  
>> +static struct resource mxc_i2c_1_resources[] = {
>> +    {
>> +       
> 
> Shouldn't the inclusion of i2c be handled by a separate patch?
doh! It seems I've handled a rebase conflict wrong.

Thanks for catching this,
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
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100722/5ef95746/attachment.sig>
