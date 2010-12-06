From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Mon, 06 Dec 2010 15:00:48 -0500
Subject: [PATCH 1/5] msm: Secure Channel Manager (SCM) support
In-Reply-To: Your message of "Sun, 05 Dec 2010 23:16:14 PST."
	<1291619778-30289-2-git-send-email-johlstei@codeaurora.org>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>
	<1291619778-30289-2-git-send-email-johlstei@codeaurora.org>
Message-ID: <29863.1291665648@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 05 Dec 2010 23:16:14 PST, Jeff Ohlstein said:

> SCM is the protocol used to communicate between the secure and
> non-secure code executing on the applications processor. 

Does the presence of SCM hardware imply SMP?  From reading this, it's unclear
why the dependence on SMP - it looks like scm.c is something that hardware that
has one ARM processor and a 'secure processor' would still want.  Or is the
'secure processor' just another (arbitrarily labeled) ARM CPU participating
as a full SMP processor?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101206/de2939f6/attachment.sig>
