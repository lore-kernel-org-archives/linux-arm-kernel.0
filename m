From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Aug 2017 16:54:37 +0200
Subject: [GIT PULL] Allwinner fixes for 4.13, take 3
In-Reply-To: <CAOesGMjcWEjY+uj1cFWkeoL=OuR9q4E2uQbZ21HVxxDqgvUtCw@mail.gmail.com>
References: <20170828092651.xwrz6toedrmht5nh@flea.lan>
 <20170830053759.GK14499@localhost>
 <20170830064322.rloouj6tso65vbin@flea.lan>
 <CAOesGMjcWEjY+uj1cFWkeoL=OuR9q4E2uQbZ21HVxxDqgvUtCw@mail.gmail.com>
Message-ID: <20170831145437.gmglnaq2hr4a7fnl@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 30, 2017 at 03:15:05PM -0700, Olof Johansson wrote:
> On Tue, Aug 29, 2017 at 11:43 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Olof,
> >
> > On Tue, Aug 29, 2017 at 10:37:59PM -0700, Olof Johansson wrote:
> >> On Mon, Aug 28, 2017 at 11:26:51AM +0200, Maxime Ripard wrote:
> >> > Hi,
> >> >
> >> > Here is a bunch of patches essentially reverting the EMAC bindings
> >> > additions. Indeed, it was discovered after the release of 4.13-rc1
> >> > that we overlooked some issues while reviewing the driver, and we
> >> > couldn't find a proper solution since then.
> >> >
> >> > Since the binding is as such not stable yet, we can't allow it to
> >> > reach a stable release.
> >> >
> >> > Maxime
> >> >
> >> > The following changes since commit d86e63e1f0b7868c55c8d4a54854b85e2bac690b:
> >> >
> >> >   arm64: allwinner: h5: fix pinctrl IRQs (2017-08-14 14:18:21 +0800)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.13-3
> >> >
> >> > for you to fetch changes up to fe45174b72aead678da581bab9e9a37c9b26a070:
> >> >
> >> >   arm: dts: sunxi: Revert EMAC changes (2017-08-28 11:11:24 +0200)
> >>
> >> Merged but unfortunately this introduces quite annoying conflicts with already
> >> queued up DT contents. Fixed up those as well.
> >
> > Yeah, sorry, I should have mentionned it. I didn't know what the best
> > strategy was in this case, since it was conflicting with some branches
> > you already had pulled. What would you have prefered ?
> 
> Just mentioning it would be appreciated to avoid surprises.
> 
> The other part would be to make sure the fixes branch is based on an
> old enough release that we can just merge it into next/dt64 without
> bringing in a much newer upstream base. You've done that in this case,
> so what I'll do at our end is merge the fixes into next/dt64 to avoid
> this from bubbling up to Linus when it's a local issue to our tree.

Ok, thanks, and sorry for that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/670a6d11/attachment.sig>
