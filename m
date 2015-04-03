From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 3 Apr 2015 22:31:35 +0200
Subject: [GIT PULL] Allwinner DT additions for 4.1
In-Reply-To: <20150403200541.GU23023@localhost>
References: <20150325212124.GA17842@lukather>
 <20150403200331.GT23023@localhost>
 <20150403200541.GU23023@localhost>
Message-ID: <20150403203135.GG14618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 01:05:41PM -0700, Olof Johansson wrote:
> > > There is mostly:
> > >   - The end of the DT relicensing. All our DT should now be under the dual
> > >     X11/GPL license.
> > >   - Convertion of all the DT to a label based syntax, instead of duplicating
> > >     the tree like was done before.
> > 
> > Ugh. This is a huge amount of churn just for the sake of it. It's much
> > better if these kind of conversions happen over time as the files are
> > touched for other reasons.
> > 
> > I've merged branches like these before, but I was grumpy when I did those too.
> > 
> > Anyway, I've merged it for now.
> 
> Ugh. Causes merge conflicts with your own fixes. Not even going to try to fix
> this up.

Does that mean that you droped the entire pull request?

The merge is quite trivial, and is in linux-next, if that can help:
6bcf44d5edfb1eaf1db56ac71742767517f6a0d0.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150403/403cdc5c/attachment.sig>
