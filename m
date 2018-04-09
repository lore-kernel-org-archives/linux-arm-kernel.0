From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Apr 2018 12:40:22 +0100
Subject: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
In-Reply-To: <20180409113744.GA14582@dragon>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180409113744.GA14582@dragon>
Message-ID: <20180409114022.GE11532@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 07:37:45PM +0800, Shawn Guo wrote:
> On Mon, Mar 05, 2018 at 11:25:17AM +0100, Oleksij Rempel wrote:

> > As this patch set touches multiple subsystems I think it would make
> > sense for Shawn Guo to take the all patch set.
> > The only part which didn't receive an ACK is regulator stuff. So I would
> > hope that Mark Brown can ACK it.

> Besides regulator changes, I did not see an ACK on kernel/reboot.c
> either.

Right, that's the big blocker here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/1561968a/attachment-0001.sig>
