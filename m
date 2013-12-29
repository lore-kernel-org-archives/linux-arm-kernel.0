From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 29 Dec 2013 20:10:42 +0100
Subject: [GIT PULL] Allwinner drivers for 3.14
In-Reply-To: <20131227212403.GC17637@quad.lixom.net>
References: <20131220221709.GA23196@lukather>
 <20131227212403.GC17637@quad.lixom.net>
Message-ID: <20131229191042.GK3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Fri, Dec 27, 2013 at 01:24:03PM -0800, Olof Johansson wrote:
> [+cc linux-arm-kernel]
> 
> On Fri, Dec 20, 2013 at 11:17:09PM +0100, Maxime Ripard wrote:
> > Hi Arnd, Kevin, Olof,
> > 
> > Please pull the following patches.
> > 
> > Thanks!
> > Maxime
> > 
> > The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> > 
> >   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/mripard/linux.git tags/sunxi-drivers-for-3.14
> > 
> > for you to fetch changes up to 594c6fb92446a07a4d12337adeb3e9fb3ec7e203:
> > 
> >   ARM: sun4i/sun7i: RTC driver (2013-12-20 22:55:03 +0100)
> 
> Pulled, thanks. The RTC driver could have gone in through the maintainer since
> there are no external dependencies.

Yes, but the RTC maintainer actually asked us (Jason Cooper and I, so
you should see one RTC driver in Marvell's pull request as well :)) to
merge the patches through our trees, since he doesn't have one, hence
why I merged it :)

> Also, in the future please cc linux-arm-kernel on your pull requests, we
> normally don't do them behind the scenes. :)

Ah, right... I somehow forgot to add it to my cc-list...

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131229/1a0f718a/attachment.sig>
