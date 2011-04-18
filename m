From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Apr 2011 06:36:20 +0200
Subject: [RFC 0/4] convert stmp into mxs and delete the obsolete platform
In-Reply-To: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
References: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110418043620.GA11578@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 04:30:34AM +0200, Wolfram Sang wrote:

> What we have here is consolidation of two platforms. The older one, plat-stmp,
> has never seen much love after the initial commit and has poor design as stated
> in the patch descriptions. The recently added mach-mxs can be used for a
> (friendly) takeover. Adding 130 lines there could save 9500+ lines in arch/arm!

Seems I was very hungry; forgot to push out the branch which is now here:

  git://git.pengutronix.de/git/wsa/linux-2.6.git remove_stmp

This should help until the patches are moderated.

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110418/b8c39767/attachment.sig>
