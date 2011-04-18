From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Apr 2011 18:25:33 +0200
Subject: [RFC 0/4] convert stmp into mxs and delete the obsolete platform
In-Reply-To: <BANLkTikybn1pwiz-SrgdSwV6aRcKHMAENg@mail.gmail.com>
References: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
	<BANLkTikybn1pwiz-SrgdSwV6aRcKHMAENg@mail.gmail.com>
Message-ID: <20110418162533.GF23814@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vitaly,

> On Mon, Apr 18, 2011 at 4:30 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > I tried a smaller scaled cleanup before, but now that there are talks about ARM
> > consolidation everywhere, I'll be more brave :)
> >
> > What we have here is consolidation of two platforms. The older one, plat-stmp,
> > has never seen much love after the initial commit and has poor design as stated
> > in the patch descriptions. The recently added mach-mxs can be used for a
> > (friendly) takeover. Adding 130 lines there could save 9500+ lines in arch/arm!
> 
> may we FIRST see how you are going to fit it into mach-mxc? NAK from
> me before I see that.

mach-mxs, not mach-mxc :) As said to Arnd, you can check the patches here

  http://git.pengutronix.de/?p=wsa/linux-2.6.git;a=shortlog;h=refs/heads/remove_stmp

until they are moderated (or pull the branch). Looking forward to input from
you and you even seem to have boards.

> unstable and painful to work with lower end i.MXs, and is also being
> killed virtually -- by you guys.

STMP378x is not killed. STMP37xx is, but I have doubts the mainline linux
support ever worked. See my patch descriptions.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110418/c551fc7e/attachment.sig>
