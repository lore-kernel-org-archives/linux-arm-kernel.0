From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 9 Apr 2018 13:43:03 +0200
Subject: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
In-Reply-To: <20180409114022.GE11532@sirena.org.uk>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180409113744.GA14582@dragon> <20180409114022.GE11532@sirena.org.uk>
Message-ID: <c3883979-8658-96d2-e62f-396aa5be332d@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.04.2018 13:40, Mark Brown wrote:
> On Mon, Apr 09, 2018 at 07:37:45PM +0800, Shawn Guo wrote:
>> On Mon, Mar 05, 2018 at 11:25:17AM +0100, Oleksij Rempel wrote:
> 
>>> As this patch set touches multiple subsystems I think it would make
>>> sense for Shawn Guo to take the all patch set.
>>> The only part which didn't receive an ACK is regulator stuff. So I would
>>> hope that Mark Brown can ACK it.
> 
>> Besides regulator changes, I did not see an ACK on kernel/reboot.c
>> either.
> 
> Right, that's the big blocker here.
> 

Ok, Who should ACK it?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/4955cbc2/attachment.sig>
