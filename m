From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 13 Jul 2012 12:35:45 +0200
Subject: [PATCH v4 2/2] serial: mxs-auart: Allow device tree probing
In-Reply-To: <4FFFF968.5000801@pengutronix.de>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <1340024769-7122-1-git-send-email-fabio.estevam@freescale.com>
 <4FDF929B.7000809@grid-net.com> <4FFFF968.5000801@pengutronix.de>
Message-ID: <4FFFFA01.6070306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2012 12:33 PM, Marc Kleine-Budde wrote:
> On 06/18/2012 10:42 PM, Subodh Nijsure wrote:
>>
>> If one were to try run console on one of the /dev/ttyAPP* ports, as is
>> the case for hardware I am working with, console output wouldn't show up
>> without the following diff:
>>
>> Let me know if should send formal patch or we can include it as part of v5?
> 
> Has this patch been applied?

Yes. [1]

Marc

[1]
http://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=commit;h=1ea6607d4cdc917987e7e6cfaafc4a630d97a297
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120713/211eb46e/attachment.sig>
