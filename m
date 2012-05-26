From: richard@nod.at (Richard Weinberger)
Date: Sat, 26 May 2012 10:55:09 +0200
Subject: [PATCH 13/20] arm: Do not call try_to_freeze() in do_signal()
In-Reply-To: <20120525234345.GA32000@n2100.arm.linux.org.uk>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
 <1337983476-22081-13-git-send-email-richard@nod.at>
 <20120525234345.GA32000@n2100.arm.linux.org.uk>
Message-ID: <4FC09A6D.4060602@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.05.2012 01:43, schrieb Russell King - ARM Linux:
> On Sat, May 26, 2012 at 12:04:29AM +0200, Richard Weinberger wrote:
>> get_signal_to_deliver() already calls try_to_freeze(), there is no
>> need to call it directly.
> 
> NAK.  Please check linux-next (okay, viro's patches haven't appeared
> there yet) but a lot of this stuff is covered by a truckload of work
> that Al's done.
> 

Okay.
I've rebased my patches to Al's signal tree to avoid further conflicts.

Thanks,
//richard

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120526/92975490/attachment.sig>
