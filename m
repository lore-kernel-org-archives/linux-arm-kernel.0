From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Dec 2013 18:59:47 +0000
Subject: Boot time errors/warnings on snowball
In-Reply-To: <CAOesGMh7+r9vUvtH_pwJeMyQJGo3u-uJRJ8-OBidzzO1pC5RDA@mail.gmail.com>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
 <20131204175119.GD26581@lee--X1>
 <CAOesGMh7+r9vUvtH_pwJeMyQJGo3u-uJRJ8-OBidzzO1pC5RDA@mail.gmail.com>
Message-ID: <20131204185947.GC29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 09:58:29AM -0800, Olof Johansson wrote:

> It can be done. It's unfortunate to lose bisectability though (since
> when you bisect you can end up in a state where the ASoC patches are
> enabled but not the ux500 counterparts. Setting up a shared branch is
> indeed the best (only) way to solve that. Next time around we should
> do so.

Right, that's why I asked about dependencies for the ASoC patch.

> We're usually fairly quick at merging our branches during the merge
> window, so sequencing should be fine. Even if Mark does his pull
> requests before us, the window of breakage should be minimal (and
> we're now aware of it).

If there's a topic branch for the ARM side I can pull it into ASoC to
get the window down to a few commits (or even rebase the ux500 stuff
onto it to remove it).  Or I can sign the ux500 branch for arm-soc.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/f1bea071/attachment.sig>
