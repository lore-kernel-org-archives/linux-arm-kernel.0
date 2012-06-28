From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Jun 2012 13:29:19 +0200
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20120628112111.GC22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
 <20120628112111.GC22990@S2101-09.ap.freescale.net>
Message-ID: <4FEC400F.8010506@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2012 01:21 PM, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 12:31:56PM +0200, Marc Kleine-Budde wrote:
>> Hmm I'm wondering if transceiver or phy is the correct name here. In
>> platform_data it's called transceiver_switch.
> 
> The transceiver_switch in platform_data names a function, while we are
> naming a couple gpios which happen to be access in that function.  It
> looks all correct to me.

I mean which name is more precise, do these gpio enable/standy a "phy"
or a "transceiver". For example:
http://www.nxp.com/documents/application_note/AN00094.pdf, this document
says: TJA1041/1041A high speed CAN transceiver.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120628/75c661b1/attachment.sig>
