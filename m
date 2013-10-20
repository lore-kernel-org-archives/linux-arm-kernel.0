From: broonie@kernel.org (Mark Brown)
Date: Sun, 20 Oct 2013 23:08:39 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <52644A9E.3060007@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>
Message-ID: <20131020220839.GT2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:

> IIRC (and perhaps I don't; it was really slightly before my active
> involvement in kernel development) Linus triggered the whole ARM DT
> conversion in response to disliking the volume of changes, and
> conflicts, in board files. The idea of DT conversion being that all the
> board-specific details could be moved out of the kernel and into DT
> files, thus causing him not to have to see it.

A large part of this was to do with the needs of distros and their users
- they have a strong need to ship a device neutral kernel and to have a
reasonable ability to have their kernel deploy on hardware unknown to
them.  Allowing the device tree to be delivered with the system rather
than have the board configuration in the kernel helps achieve that goal.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131020/9f27877f/attachment.sig>
