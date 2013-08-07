From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 07 Aug 2013 09:35:35 +0200
Subject: [PATCH v4 11/31] net: can: mscan: improve clock API use
In-Reply-To: <5201F7A7.90906@pengutronix.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-12-git-send-email-gsi@denx.de>
 <5201F7A7.90906@pengutronix.de>
Message-ID: <5201F8C7.6090208@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 09:30 AM, Marc Kleine-Budde wrote:
> On 08/06/2013 10:43 PM, Gerhard Sittig wrote:
>> the .get_clock() callback is run from probe() and might allocate
>> resources, introduce a .put_clock() callback that is run from remove()
>> to undo any allocation activities
> 
> AFAICS With this patch put_clock() is still a no-op, is there a patch
> which adds some code there? If not, please remove.

I missed patch 27.

sorry for the noise.
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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/1214eb32/attachment-0001.sig>
