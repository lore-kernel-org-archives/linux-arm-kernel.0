From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 23 Jul 2012 11:30:18 +0200
Subject: [PATCH v2 1/2] USB: chipidea: add imx usbmisc support
In-Reply-To: <20120723092713.GS21635@b20223-02.ap.freescale.net>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
 <1342607348-8587-2-git-send-email-richard.zhao@freescale.com>
 <20120723091652.GK8265@arwen.pp.htv.fi>
 <20120723092713.GS21635@b20223-02.ap.freescale.net>
Message-ID: <500D19AA.8080006@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2012 11:27 AM, Richard Zhao wrote:
>> This patch looks like a recipe for disaster IMHO, but it's Alex's call.
> Well, if there's any better place to hold it, I'd like to move there.
> Another place is arch/arm/mach-imx. Sascha/Shawn who are maintainers of
> imx are also in cc list.

IMHO it's not about the place where the driver is located, it's about
the shortcomings Michael and Sascha mentioned.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/b2a02636/attachment.sig>
