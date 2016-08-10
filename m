From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 10 Aug 2016 13:29:32 +0300
Subject: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
In-Reply-To: <20160727195700.GE5629@pengutronix.de>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56E2AA80.4050908@ti.com> <20160420191727.GS29108@pengutronix.de>
 <20160705100902.GM16643@pengutronix.de>
 <20160727195700.GE5629@pengutronix.de>
Message-ID: <bdcfe5b1-3d95-03a3-728b-a80f86c95932@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/07/16 22:57, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Jul 05, 2016 at 12:09:02PM +0200, Uwe Kleine-K?nig wrote:
>> To reach my goal to keep the display on (showing whatever the bootloader
>> initialized the display with) until the application starts caring for
>> the display some driver must enable the regulator. The only candidates
>> are the lcd driver (i.e. the patch under discussion) or some mechanism
>> in the fb core. As there doesn't seem to be code in the core (and the
>> core is dead?) what do you suggest me to do?
> 
> Unfortunately I didn't get an answer here. Do you still have this mail
> on your radar?

Can you resend the series? And I think I had comments about the third
patch, to which I don't see any reply.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160810/c27be42b/attachment.sig>
