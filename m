From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Nov 2013 17:44:31 +0100
Subject: [PATCH] ARM: i.MX6q: fix the wrong parent of can_root clock
In-Reply-To: <20131031073820.GH23549@S2101-09.ap.freescale.net>
References: <1383132351-32112-1-git-send-email-jiada_wang@mentor.com>
 <20131031073820.GH23549@S2101-09.ap.freescale.net>
Message-ID: <52937E6F.1020102@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2013 08:38 AM, Shawn Guo wrote:
> On Wed, Oct 30, 2013 at 04:25:51AM -0700, jiada_wang at mentor.com wrote:
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> instead of pll3_usb_otg the parent of can_root clock
>> should be pll3_60m.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> 
> Applied, thanks.

Can you put stable on Cc?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/ff7cd857/attachment.sig>
