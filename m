From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Jun 2012 14:10:21 +0200
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20120628120835.GA3402@vandijck-laurijssen.be>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
 <20120628112111.GC22990@S2101-09.ap.freescale.net>
 <4FEC400F.8010506@pengutronix.de>
 <20120628114108.GD22990@S2101-09.ap.freescale.net>
 <20120628120835.GA3402@vandijck-laurijssen.be>
Message-ID: <4FEC49AD.1000609@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2012 02:08 PM, Kurt Van Dijck wrote:
> On Thu, Jun 28, 2012 at 07:41:10PM +0800, Shawn Guo wrote:
>> On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote:
>>> I mean which name is more precise, do these gpio enable/standy a "phy"
>>> or a "transceiver". For example:
>>> http://www.nxp.com/documents/application_note/AN00094.pdf, this document
>>> says: TJA1041/1041A high speed CAN transceiver.
>>>
>> Isn't term "phy" (physical interface) generally meant to be the same
>> thing as "transceiver"?  I just happened to like the shorter one as
>> what Hui did in his patch.
> 
> 'trx' seemed the right abbreviation
> http://www.acronymfinder.com/TRX.html
> 
> thanks to Oliver, in his email on May 9th.

I was about to propose CamelCase to keep the variable names shorter:

bool transceiverStbyActiveLow;

scnr, Marc

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120628/667b8137/attachment.sig>
