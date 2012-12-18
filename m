From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Dec 2012 07:21:30 -0800
Subject: [GIT PULL] ARM: arm-soc fixes for 3.8
In-Reply-To: <50D08547.8040405@free-electrons.com>
References: <20121218065502.GA12865@quad.lixom.net>
 <50D08547.8040405@free-electrons.com>
Message-ID: <CAOesGMgunMue3=Fwq2S2wxpcDcc-vKrQa=qzKQciuXJQwuYi0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 18, 2012 7:01 AM, "Maxime Ripard" <maxime.ripard@free-electrons.com>
wrote:
>
> Hi Olof,
>
> Le 18/12/2012 07:55, Olof Johansson a ?crit :
> > Maxime Ripard (1):
> >       ARM: sunxi: Change device tree naming scheme for sunxi
>
> There's something odd about this one (commit 68136b10). The patch that
> you seem to have applied differs from the one I sent. The DTs files
> appears to have not been renamed, while in the patch I sent
> (
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137105.html
),
> it's the case.
>
> Do you know what happened here? What can we do to fix that?

Ah, probably didn't apply right since the patch didn't do delete+add.
Shoulda checked, my bad.

I'm traveling today but will revisit when I'm back online.

Linus, please hold off merging if you haven't already done so, new pull
request tomorrow.

-Olof
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121218/2af75b05/attachment-0001.html>
