From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Jan 2014 12:23:06 +0000
Subject: [PATCH 1/9] spi: rspi: Add missing clk_disable() calls in error
 and cleanup paths
In-Reply-To: <CAMuHMdVjkWD0nP-9f579kUOqG4EVsy9Yp+vwNsM_=LxNU=Bdzg@mail.gmail.com>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
 <20140113115947.GL29039@sirena.org.uk>
 <CAMuHMdVjkWD0nP-9f579kUOqG4EVsy9Yp+vwNsM_=LxNU=Bdzg@mail.gmail.com>
Message-ID: <20140113122306.GS29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 01:17:18PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 13, 2014 at 12:59 PM, Mark Brown <broonie@kernel.org> wrote:

> > This doesn't seem to apply to current code, please check and resend.
> > The fact that there's multiple patch serieses in flight from you for
> > this driver plus development work (again mostly from you) in git is
> > probably not helping here...

> This depends on the series:

> [PATCH V2 0/8] spi: rspi: Add support for RZ/A1H

Please say if you're doing things like that, or ideally just send one
patch series since everything needs to be applied as one series - in
this case since the patch is a bug fix it ought to be going in before
anything else anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/db0c5e63/attachment.sig>
