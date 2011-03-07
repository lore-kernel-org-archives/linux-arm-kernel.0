From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 07 Mar 2011 11:16:49 +0100
Subject: [PATCHv2 0/4] Continue the mx31_3ds machine support
In-Reply-To: <1299492598.2468.30.camel@realization>
References: <1299492598.2468.30.camel@realization>
Message-ID: <4D74B091.2010908@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2011 11:09 AM, Alberto Panizzo wrote:
> Hello,
> 
> this series on top of Sascha's imx-for-2.6.39 branch continue the
> support of peripherals for the machine mx31_3ds.
> 
> The first one fix also a kernel NULL pointer error introduced by
> 4d2f13be1e370a670c1cae20c194d5ce961e0fa5

IMHO:
This should go into the patch description of the first patch, too.
> 
> In v2 all group of GPIO requests are packed with gpio_request_array
> 
> Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110307/95a877fb/attachment.sig>
