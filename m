From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 16 Nov 2012 11:19:35 +0100
Subject: [PATCH 3/9] usb: chipidea: ci13xxx-imx: create dynamic
 platformdata
In-Reply-To: <87ehjt7t2k.fsf@ashishki-desk.ger.corp.intel.com>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-4-git-send-email-m.grzeschik@pengutronix.de>
 <87ehjt7t2k.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <50A61337.7010105@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 11:14 AM, Alexander Shishkin wrote:
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> 
>> This patch removes the limitation of having only one instance of the
>> ci13xxx-imx platformdata and makes different configurations possible.
> 
> In more honest wording it should probably say: "makes using different
> phys possible", but this is fine too. :)

Granted, but later patches add support for different phy configurations. :D

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/3828570c/attachment.sig>
