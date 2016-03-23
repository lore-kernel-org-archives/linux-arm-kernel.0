From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 23 Mar 2016 22:11:44 +0100
Subject: [PATCH v5 0/2] power: reset: support for Atmel alternative
 Shutdown Controller
In-Reply-To: <56F27B96.5010406@atmel.com>
References: <1458134390-23847-1-git-send-email-nicolas.ferre@atmel.com>
 <56F27B96.5010406@atmel.com>
Message-ID: <20160323211144.GA31473@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Mar 23, 2016 at 12:18:46PM +0100, Nicolas Ferre wrote:
> Le 16/03/2016 14:19, Nicolas Ferre a ?crit :
> > This is a series to add driver for a new Atmel Shutdown Controller. This new IP
> > is extensible and some features will be added later (see the TODO section).
> > Its extensible nature led to write a new binding so that wake-up sources can be
> > described easily.
> 
> I have the feeling that this series is ready. What do you think?

I have see obvious problems with this series and plan to queue this
after the merge window has closed. I give patches one more review
while applying them, so at that point something might turn up.

> So, do you want me to collect everybody's tags and send another version
> or you can do it yourself?

I can collect the tags myself.

> BTW, I will certainly send the device tree updates for the sama5d2 SoC,
> but it will go through the AT91 then arm-soc git trees. No need for
> further synchronization here.

I will ignore the *.dts patches.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/f01651fe/attachment.sig>
