From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 14:49:27 +0200
Subject: [PATCH 0/3] usb: chipidea: fix error handling and add dr_role
 property
In-Reply-To: <20120627124233.GA2256@richard-laptop>
References: <1340799710-32696-1-git-send-email-mkl@pengutronix.de>
 <20120627124233.GA2256@richard-laptop>
Message-ID: <4FEB0157.5070404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2012 02:42 PM, Richard Zhao wrote:
> On Wed, Jun 27, 2012 at 02:21:47PM +0200, Marc Kleine-Budde wrote:
>> Hello,
>>
>> while hacking on the chipidea driver, I fixed the error path in
>> the udc part of the chipidea driver. Further I added the possibility
>> to limit the driver to host or device only mode. It's possible via
>> platformdata and device tree. For dt I selected the dr_role property
>> which is already used for other dual role usb drivers.
> What's it based on then?

Your tree:
https://github.com/riczhao/kernel-imx/commits/topics/usb-driver

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/90b62bf5/attachment.sig>
