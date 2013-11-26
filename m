From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 26 Nov 2013 09:34:07 +0100
Subject: [PATCH] ARM: i.MX6q: fix the wrong parent of can_root clock
In-Reply-To: <20131126021946.GC30476@S2101-09.ap.freescale.net>
References: <1383132351-32112-1-git-send-email-jiada_wang@mentor.com>
 <20131031073820.GH23549@S2101-09.ap.freescale.net>
 <52937E6F.1020102@pengutronix.de>
 <20131126021946.GC30476@S2101-09.ap.freescale.net>
Message-ID: <52945CFF.8000008@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 03:19 AM, Shawn Guo wrote:
> On Mon, Nov 25, 2013 at 05:44:31PM +0100, Marc Kleine-Budde wrote:
>> On 10/31/2013 08:38 AM, Shawn Guo wrote:
>>> On Wed, Oct 30, 2013 at 04:25:51AM -0700, jiada_wang at mentor.com wrote:
>>>> From: Jiada Wang <jiada_wang@mentor.com>
>>>>
>>>> instead of pll3_usb_otg the parent of can_root clock
>>>> should be pll3_60m.
>>>>
>>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>>
>>> Applied, thanks.
>>
>> Can you put stable on Cc?
> 
> Sorry, it already hits mainline.

No problem, I'll write stable and Greg directly.

> I generally do not judge if a patch is suitable for stable tree, and
> rely on patch sender to explicitly request by marking stable and the
> prerequisite commits if any.

Together with the Flexcan clock (can: flexcan: use correct clock as base
for bit rate calculation) this fixes the CAN on imx6.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/5ba0f0f8/attachment.sig>
