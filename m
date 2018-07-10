From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 10:13:48 +0200
Subject: [PATCH v5 02/22] fixup! v4l2-ctrls: add
 v4l2_ctrl_request_hdl_find/put/ctrl_find functions
In-Reply-To: <CAMuHMdVgJuK5G0+szV0BAWDBybxWV0iDWE5kZKuTdgNiGjpnEg@mail.gmail.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-3-paul.kocialkowski@bootlin.com>
 <CAMuHMdVgJuK5G0+szV0BAWDBybxWV0iDWE5kZKuTdgNiGjpnEg@mail.gmail.com>
Message-ID: <5adf8a6aa70fd6f7f4326ccb068b66d6221d8d8b.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2018-07-10 at 10:07 +0200, Geert Uytterhoeven wrote:
> On Tue, Jul 10, 2018 at 10:02 AM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > [PATCH v5 02/22] fixup! v4l2-ctrls: add v4l2_ctrl_request_hdl_find/put/ctrl_find functions
> 
> git rebase -i ;-)

Although I should have mentionned it (and did not), this is totally
intentional! The first patch (from Hans Verkuil) requires said fixup to
work properly. I didn't want to squash that change into the commit to
make the diff obvious.

Ultimately, this framework patch is not really part of the series but is
one of its underlying requirements, that should be merged separately (as
part of the requests API series).

I hope this clears up some of the confusion about this patch :)

Cheers!

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/8fa5c1f7/attachment.sig>
